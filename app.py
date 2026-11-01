import random
from http.server import BaseHTTPRequestHandler, HTTPServer

QUOTES = [
    "Make it work, then make it right.",
    "Simple is better than complex.",
    "Automate the boring parts.",
    "Done is better than perfect.",
]

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            status = 200
            body = "Quotes API\n"
        elif self.path == "/quote":
            status = 200
            body = random.choice(QUOTES) + "\n"
        elif self.path == "/health":
            status = 200
            body = "OK\n"
        else:
            status = 404
            body = "Not found\n"
        self.send_response(status)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        self.wfile.write(body.encode())

HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()


