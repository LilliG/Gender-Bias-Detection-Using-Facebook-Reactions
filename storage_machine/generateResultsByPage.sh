echo Average entropy \for each pages posts controlling \for date:
psql -d lmgray16_senior_project -U lmgray16 -c "select pages.name, gender, avg(posts.entropy)
from posts,pages

where (posts.page_id=pages.page_id) and

((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5))

group by pages.page_id
order by avg;"

echo
echo Average entropy \for each pages posts controlling \for minimum reactions:
psql -d lmgray16_senior_project -U lmgray16 -c "select pages.name, gender, avg(posts.entropy)
from posts,pages

where (posts.page_id=pages.page_id)

and ((likes + ahah + love + wow + sigh + grrr)>20)

group by pages.page_id
order by avg;"

echo
echo Average entropy \for each pages posts controlling \for date and minimum reactions:
psql -d lmgray16_senior_project -U lmgray16 -c "select pages.name, gender, avg(posts.entropy)
from posts,pages

where (posts.page_id=pages.page_id) and

((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5))

and ((likes + ahah + love + wow + sigh + grrr)>20)

group by pages.page_id
order by avg;"