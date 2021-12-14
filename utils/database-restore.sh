docker exec -i app_mysql_1 sh -c 'exec mysql directus -udirectus -p"directus"' < ../directus/site.sql
