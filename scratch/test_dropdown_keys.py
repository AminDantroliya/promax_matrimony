import urllib.request
import json
import ssl

context = ssl._create_unverified_context()

url = "https://promax.narjisinfotech.com/api/common-request/get-common-dropdown-list"
req = urllib.request.Request(url, headers={"lang_code": "en"})

try:
    with urllib.request.urlopen(req, context=context) as response:
        print("Status code:", response.status)
        data = json.loads(response.read().decode())
        print("Top level keys in response.json():", data.keys())
        if "data" in data and data["data"] is not None:
            data_obj = data["data"]
            print("Keys in data object:", data_obj.keys())
            for key in sorted(data_obj.keys()):
                val = data_obj[key]
                if isinstance(val, list):
                    print(f"Key '{key}' has list of size {len(val)}. First 3 elements:")
                    for item in val[:3]:
                        print("  ", item)
                else:
                    print(f"Key '{key}' has type {type(val)}: {str(val)[:100]}")
        else:
            print("Data object is null or not found")
except Exception as e:
    print("Error calling get-common-dropdown-list:", e)
