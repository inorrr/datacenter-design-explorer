import sqlite3,json,pathlib
root=pathlib.Path(__file__).resolve().parents[1]
c=sqlite3.connect(':memory:');c.execute('PRAGMA foreign_keys=ON')
for p in sorted((root/'drizzle').glob('*.sql')):c.executescript(p.read_text())
d=json.loads((root/'db/seed/evidence.json').read_text())
def insert(table,obj):
 keys=list(obj);c.execute('INSERT OR IGNORE INTO '+table+' ('+','.join(keys)+') VALUES ('+','.join('?' for _ in keys)+')',[obj[k] for k in keys])
for _ in range(2):
 for x in d['countries']:insert('countries',x)
 for x in d['sources']:insert('sources',x)
 insert('designs',dict(id='baseline',team_id='course-consortium',current_revision=1,it_load_mw=20,pue=1.25,cooling='concept',backup='concept',network='concept',storage='concept',summary='concept',inputs_json='{}',updated_at='2026-10-05'))
 for x in d['claims']:insert('design_claims',x)
 for x in d['metrics']:insert('metrics',x)
assert c.execute('SELECT COUNT(*) FROM sources').fetchone()[0]==len(d['sources'])
assert c.execute('SELECT COUNT(*) FROM metrics').fetchone()[0]==len(d['metrics'])
assert not c.execute('PRAGMA foreign_key_check').fetchall()
print('PASS: schema migration, foreign keys, repeatable seed, versioned researched metrics and API observations. SQLite fixture, not production D1 integration.')
