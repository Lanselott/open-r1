import http.client
import json

conn = http.client.HTTPSConnection("cloud.infini-ai.com")

payload = "{\n  \"model\": \"qwen2.5-7b-instruct\",\n  \"messages\": [\n    {\n      \"role\": \"user\",\n      \"content\": \"9.11 and 9.8 which one is bigger?\"\n    }\n  ],\n  \"stream\": false,\n  \"temperature\": 0.7,\n  \"top_p\": 1,\n  \"top_k\": -1,\n  \"n\": 1,\n  \"max_tokens\": null,\n  \"stop\": null,\n  \"presence_penalty\": 0,\n  \"frequency_penalty\": 0\n}"

headers = {
    'Content-Type': "application/json",
    'Accept': "application/json, text/event-stream, */*",
    'Authorization': "Bearer sk-dav3micfk6ekrvzd"
}

conn.request("POST", "/maas/v1/chat/completions", payload, headers)

res = conn.getresponse()
data = res.read()
response = data.decode("utf-8")
content = json.loads(response)["choices"][0]["message"]["content"]
