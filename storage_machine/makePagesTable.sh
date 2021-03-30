FILE=/eccs/users/lmgray16/cs488/pageData/converted/candidate_data.csv

psql -d lmgray16_senior_project -U lmgray16 -c "DROP TABLE IF EXISTS pages;"
psql -d lmgray16_senior_project -U lmgray16 -c "CREATE TABLE pages(name TEXT, gender char(1), page_name TEXT, page_id TEXT PRIMARY KEY, election TEXT, party TEXT, incumbent_status INT, challenged_in_primary BOOL, challenged_in_general BOOL, posts_collected INT, notes TEXT, entropy NUMERIC);"
psql -d lmgray16_senior_project -U lmgray16 -c "\copy pages FROM '$FILE' DELIMITER ',' CSV HEADER;"
psql -d lmgray16_senior_project -U lmgray16 -c "CREATE INDEX posts_page_id on posts(page_id);"
psql -d lmgray16_senior_project -U lmgray16 -c "UPDATE pages SET posts_collected=(select count(*) from posts where pages.page_id=posts.page_id);"