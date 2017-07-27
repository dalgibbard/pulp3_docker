# pulp3_docker
Attempting to spawn Pulp3 (non-stable dev branch) within Docker

## To Use:
* Make sure you have Docker installed
* Install docker-compose if you haven't already:
```
pip install docker-compose
```
* Clone this repo
* Run it
```
cd pulp3_docker
docker-compose up
```

## Notes:
* THIS IS ONLY FOR LOCAL TESTING
* There are passwords defined in docker-compose.yml which can/should be overwritten.
* This may stop working if the current pulp3 branch has issues (and as an dev release, is subject to potential problems)
