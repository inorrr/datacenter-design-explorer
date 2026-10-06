import evidence from '../../db/seed/evidence.json';
import {db,stmt,one,audit} from './repository';
import {DEFAULTS,FIXED} from '../shared/model';
function insert(table:string,obj:any){const keys=Object.keys(obj);return stmt(`INSERT OR IGNORE INTO ${table} (${keys.join(',')}) VALUES (${keys.map(()=>'?').join(',')})`,keys.map(k=>obj[k]));}
export async function seed(actor:string|null=null,requestId=crypto.randomUUID()){
 const now=new Date().toISOString(),inputs=JSON.stringify({...DEFAULTS,fixed:FIXED});
 const current=await one("SELECT * FROM designs WHERE id='baseline'");
 const previous=current?JSON.parse(current.inputs_json):null;
 const changed=!!current&&previous.fixed?.pricingVersion!==FIXED.pricingVersion;
 const revision=current?(current.current_revision+(changed?1:0)):1;
 const design={id:'baseline',team_id:'course-consortium',selected_country_id:null,current_revision:1,it_load_mw:20,pue:1.25,cooling:'Closed-loop direct-to-chip liquid cooling; dry cooler / economizer; water use requires study',backup:'UPS 10-minute ride-through assumption; N+1 5 MW generator modules, critical-load shedding; fuel volume unknown',network:'Two diverse carriers and paths; InfiniBand training fabric; isolation by institution',storage:'Parallel scratch plus replicated object/archive storage; throughput/capacity TBD',summary:'Concept only; no site, member commitments or utility offer',inputs_json:inputs,updated_at:now};
 const evidenceSnapshot=JSON.stringify({claim_ids:evidence.claims.map(x=>x.id),metric_ids:evidence.metrics.map(x=>x.id)});
 const statements=[...evidence.countries.map(x=>insert('countries',x)),...evidence.sources.map(x=>insert('sources',x)),insert('designs',design),...evidence.claims.map(x=>insert('design_claims',x)),...evidence.metrics.map(x=>insert('metrics',x))];
 if(!current)statements.push(insert('design_revisions',{id:'baseline:1',design_id:'baseline',revision:1,inputs_json:inputs,evidence_snapshot:evidenceSnapshot,reason:'PRD baseline with researched country benchmarks',actor_id:actor,created_at:now}));
 if(changed){const revised=JSON.stringify({...previous,fixed:FIXED});statements.push(stmt('INSERT INTO design_revisions (id,design_id,revision,inputs_json,evidence_snapshot,reason,actor_id,created_at) SELECT ?,?,?,?,?,?,?,? WHERE EXISTS (SELECT 1 FROM designs WHERE id=? AND current_revision=?)',['baseline:'+revision,'baseline',revision,revised,evidenceSnapshot,'Researched country prices '+FIXED.pricingVersion+'; original controls and selection preserved',actor,now,'baseline',current.current_revision]),stmt('UPDATE designs SET inputs_json=?,current_revision=?,updated_at=? WHERE id=? AND current_revision=?',[revised,revision,now,'baseline',current.current_revision]));}
 statements.push(audit(requestId,actor,'research_inventory_synchronized','baseline',{pricing_version:FIXED.pricingVersion,revision,source_ids:evidence.sources.map(x=>x.id),claim_ids:evidence.claims.map(x=>x.id),reason:'Primary-source price and policy research; historical records retained'}));
 await db().batch(statements);
 return {sources:evidence.sources.length,claims:evidence.claims.length,revision,pricing_version:FIXED.pricingVersion};
}
