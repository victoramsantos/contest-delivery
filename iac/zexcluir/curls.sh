# calculateOrder
#curl  --header "Content-Type: application/json" \
#      --request POST \
#      --data '{"order":[{"id": 1, "amount": 2}, {"id": 3, "amount": 1}]}' \
#        https://o95f424bwl.execute-api.us-east-1.amazonaws.com/developer/calculateOrder

# updateProduct
#curl  --header "Content-Type: application/json" \
#      --request POST \
#      --data '{"product":{"id": 1, "name": "Brahma zero", "price": 2.50}}' \
#        https://o95f424bwl.execute-api.us-east-1.amazonaws.com/developer/updateOrder

# notifyCarrier
curl  --header "Content-Type: application/json" \
      --request POST \
      --data '{"message":"There are a new order at ADDRESS."}' \
        https://o95f424bwl.execute-api.us-east-1.amazonaws.com/developer/notifyCarrier
