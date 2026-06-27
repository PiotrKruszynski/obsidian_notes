snowflake

warehouse -> compute
data catalog - catalog - horizon catalog (wewnetrzny)

table format 

w snowflake role sa istotne, inno sie zmienia a role zostaja z uprawnieniami do obiektu

tpch -> do testowania baz danych

dbt - 

https://github.com/dbt-labs/dbt-core

jest dostepne w snowflake!

convencion over - sprawdzic napisac ta zasade dla snowflake

materializacja - sposob zapisu modelu

modele moga od siebie zalezec, to najwazniejsze byty w dbt

wszystkie info o projekcie![[Pasted image 20260627115903.png]]

konfikuracje powiinno sie podawac pod katalog / projekt

zaelismy od tego a potem zrobimy projekt nowy z github
![[Pasted image 20260627121508.png]]
![[Pasted image 20260627131719.png]]



nowy projekt
zaczynamy od polwolenia snowflakeowi do korzystania z github
```
create or replace api integration github

    api_provider = git_https_api

    api_allowed_prefixes = ('https://github.com')

    enabled = true

    allowed_authentication_secrets = all;

  

SHOW API INTEGRATIONS;
```
![[Pasted image 20260627132047.png]]

https://github.com/bigdatapassionpl/dbt_tpch 

plik profiles.yml nie powinien byc w git tylkko na katalogu domowym lub z projektem


skonfigurowalismy
![[Pasted image 20260627133540.png]]

teraz seed -> slowniki, to drugi rodzaj obiektow obok modeli

medallion Architecture
https://www.databricks.com/blog/what-is-medallion-architecture

![[Pasted image 20260627135006.png]]
te katalogi odpowiadaja kataloga bronze silver gold i moznaby je zmienic. pamietaj ze dbt trakture kazdy katalog jako warstwe.

tu info co gdzie trafia
![[Pasted image 20260627135323.png]]

