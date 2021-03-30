echo Average entropy across all posts:
psql -d lmgray16_senior_project -U lmgray16 -c "select avg(posts.entropy)
from posts,pages
where posts.page_id=pages.page_id;"

echo
echo Average entropy across all posts \for pages of male and female politicians:
psql -d lmgray16_senior_project -U lmgray16 -c "select gender, avg(posts.entropy)
from posts,pages
where posts.page_id=pages.page_id
group by gender;"

echo
echo Average entropy across all posts from 09/2019-04/2020:
psql -d lmgray16_senior_project -U lmgray16 -c "select avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id) and
((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5));"

echo
echo Average entropy across all posts from 09/2019-04/2020 \for pages of male and female politicians:
psql -d lmgray16_senior_project -U lmgray16 -c "select gender, avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id) and

((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5))
group by gender;"

echo
echo Average entropy across all posts having at least 20 total reactions: 
psql -d lmgray16_senior_project -U lmgray16 -c "select avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id)
and ((likes + ahah + love + wow + sigh + grrr)>20);"

echo
echo Average entropy across all posts having at least 20 total reactions \for pages of male and female politicians:
psql -d lmgray16_senior_project -U lmgray16 -c "select gender, avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id)
and ((likes + ahah + love + wow + sigh + grrr)>20)
group by gender;"

echo
echo Average entropy across all posts controlling \for date and minimum reactions:
psql -d lmgray16_senior_project -U lmgray16 -c "select avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id) and

((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5))

and ((likes + ahah + love + wow + sigh + grrr)>20);"

echo
echo Average entropy across all posts controlling \for date and minimum reactions \for pages of male and female politicians:
psql -d lmgray16_senior_project -U lmgray16 -c "select gender, avg(posts.entropy)
from posts,pages
where (posts.page_id=pages.page_id) and

((cast(to_char(date, 'MM') as integer)>=9)
or
(cast(to_char(date, 'YYYY') as integer)=2020
and cast(to_char(date, 'MM') as integer)!=5))

and ((likes + ahah + love + wow + sigh + grrr)>20)
group by gender;"