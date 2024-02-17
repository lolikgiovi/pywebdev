from socketify import App

app = App()

@app.get("/")
def hello_handler(res, req):
    res.end("Hello, World with Socketify!")

def on_server_start(config):
    print(f"Listening on port http://localhost:{config.port}\n")

if __name__ == "__main__":
    app.listen(8080, on_server_start)
    app.run()