upstream serv {
    server non-stop-a.internal:80;
    server non-stop-b.internal:80;
}
server {
    listen 80;
        
    location / 
    {
        proxy_pass http://serv;
    }
}
