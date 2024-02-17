from http.server import SimpleHTTPRequestHandler
import socketserver

PORT = 8080
Handler = SimpleHTTPRequestHandler

with socketserver.TCPServer(("localhost", PORT), Handler) as httpd:
    print("serving at port", PORT)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("Server stopped")
        httpd.server_close()

# http://localhost:8080/src/day_4/assignment/hello_world/ 