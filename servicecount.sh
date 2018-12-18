running=$(docker service ls | grep -v ucp | grep -v ' 0/' | grep -v NAME |wc|awk '{print $1}' )
failing=$(docker service ls | grep ' 0/' | grep -v ucp |wc|awk '{print $1}')
total=$(docker service ls | grep -v ucp | grep -v NAME |wc|awk '{print $1}')
(( success = (( $running * 100 )) / $total ))

echo "====================="
echo "QA Service Status    "
echo "====================="
echo "Total Deployed===> "$total
echo "Total Success====> "$running
echo "Total Failed ====> "$failing
echo "Success Rate ====> "$success %
echo "====================="

if [[ $failing -gt 0 ]]; then
echo "Following Services are failing : "
echo "=============================="
docker service ls | grep ' 0/' | grep -v ucp | awk '{print $2}' |sort
echo "=============================="
fi
echo "Node Status:"
echo "============"
echo "Active nodes : $(docker node ls | grep -e Ready -e Active | wc | awk '{print $1}')"
echo "Unhealthy Nodes: $(docker node ls | grep -v Ready | grep -v ID |wc | awk '{print $1}' )"
docker node ls | grep -v Ready | grep -v ID | awk '{print $2}' | sort
echo "============"
