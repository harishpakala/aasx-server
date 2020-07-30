#! /bin/bash
docker stop AasxServer || true && docker rm AasxServer || true
#docker exec -it  AasxServer aasxserver-img /bin/bash
docker run -it -p 51210:51210 -p 51310:51310 --name AasxServer aasxserver-img
