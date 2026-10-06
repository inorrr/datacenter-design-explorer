import sqlite3,json,pathlib
r=pathlib.Path(__file__).resolve().parents[1];e=json.loads((r/'db/seed/evidence.json').read_text());old={'countries':e['countries'],'sources':[x for x in e['sources'] if int(x['id'][1:])<28],'claims':[x for x in e['claims'] if int(x['id'][1:])<35],'metrics':e['metrics'],'design':{'id':'baseline','team_id':'course-consortium','current_revision':4,'selected_country_id':'CAN','it_load_mw':20,'pue':1.4,'cooling':'existing concept','backup':'existing concept','network':'existing concept','storage':'existing concept','summary':'existing concept','inputs_json':json.dumps({'itLoadMw':20,'pue':1.4,'country':'CAN','fixed':{'pricingVersion':'research-2026-10-05','gpuPrice':30000}}),'updated_at':'2026-10-05'}}
c=sqlite3.connect(':memory:');c.execute('PRAGMA foreign_keys=ON');c.executescript((r/'drizzle/0000_unknown_argent.sql').read_text())
def add(table,row):
 keys=list(row);c.execute('INSERT OR IGNORE INTO '+table+' ('+','.join(keys)+') VALUES ('+','.join('?' for _ in keys)+')',[row[k] for k in keys])
if old:
 for x in old['countries']:add('countries',x)
 for x in old['sources']:add('sources',x)
 d=old['design'];add('designs',d)
 for x in old['claims']:add('design_claims',x)
 for x in old['metrics']:add('metrics',x)
 c.commit()
script=(r/'drizzle/0001_ownership_research.sql').read_text();c.executescript(script)
first=c.execute("SELECT current_revision,pue,selected_country_id,inputs_json FROM designs WHERE id='baseline'").fetchone();c.executescript(script)
second=c.execute("SELECT current_revision,pue,selected_country_id,inputs_json FROM designs WHERE id='baseline'").fetchone();assert first==second
if old:assert first[0]==d['current_revision']+1 and first[1]==d['pue'] and first[2]==d['selected_country_id']
assert json.loads(first[3])['fixed']['gpuPrice']==39990.5
assert c.execute('SELECT COUNT(*) FROM sources').fetchone()[0]==33
assert c.execute('SELECT COUNT(*) FROM design_claims').fetchone()[0]==40
assert not c.execute('PRAGMA foreign_key_check').fetchall()
print('PASS: ownership data migration preserves controls/selection and old evidence, appends one revision, repeats without mutation; SQLite fixture, not live D1.')
