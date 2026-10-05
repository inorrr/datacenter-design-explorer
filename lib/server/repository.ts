import {env} from 'cloudflare:workers';
export const runtime=()=>env as any;
export function db(){const d=runtime().DB;if(!d)throw Error('DB_UNAVAILABLE');return d;}
export async function all(sql:string,args:any[]=[]){return (await db().prepare(sql).bind(...args).all()).results;}
export async function one(sql:string,args:any[]=[]){return db().prepare(sql).bind(...args).first();}
export function stmt(sql:string,args:any[]=[]){return db().prepare(sql).bind(...args);}
export async function snapshot(){const [design,sources,claims,metrics,countries]=await Promise.all([one("SELECT * FROM designs WHERE id='baseline'"),all('SELECT * FROM sources ORDER BY id'),all('SELECT * FROM design_claims ORDER BY id'),all('SELECT * FROM metrics ORDER BY retrieved_at DESC,id'),all('SELECT * FROM countries ORDER BY name')]);if(!design)throw Error('SEED_REQUIRED');const hash=await digest(JSON.stringify({revision:design.current_revision,claims:claims.map((x:any)=>x.id),metrics:metrics.map((x:any)=>x.id)}));return {design,sources,claims,metrics,countries,hash};}
export async function digest(s:string){return Array.from(new Uint8Array(await crypto.subtle.digest('SHA-256',new TextEncoder().encode(s)))).map(x=>x.toString(16).padStart(2,'0')).join('');}
export function audit(id:string,actor:string|null,event:string,entity:string,meta:any,outcome='success'){return stmt('INSERT INTO audit_events (id,timestamp,request_id,event_type,actor_id,team_id,entity_id,metadata,outcome) VALUES (?,?,?,?,?,?,?,?,?)',[crypto.randomUUID(),new Date().toISOString(),id,event,actor,'course-consortium',entity,JSON.stringify(meta),outcome]);}
