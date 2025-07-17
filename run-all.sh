#!/bin/bash

# Start backend (Spring Boot) in background
cd sm-shop
./mvnw spring-boot:run -Dspring-boot.run.profiles=mysql &
BE_PID=$!
cd ..

# Start frontend (ReactJS) in background with Node 17+ compatibility
cd shopizer-shop-reactjs
NODE_OPTIONS=--openssl-legacy-provider npm start &
FE_PID=$!
cd ..

# Display info
sleep 3
echo "----------------------------------------"
echo "Shopizer backend (BE) is running on port 8080."
echo "Shopizer frontend (FE) is running on port 3000."
echo "BE PID: $BE_PID"
echo "FE PID: $FE_PID"
echo "----------------------------------------"
echo "To stop both, run: kill $BE_PID $FE_PID"

# Wait for both processes
wait $BE_PID $FE_PID 