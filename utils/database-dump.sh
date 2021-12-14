docker exec app_mysql_1 sh -c 'exec mysqldump directus --no-tablespaces -u"directus" -p"directus"' > ../directus/site.sql
