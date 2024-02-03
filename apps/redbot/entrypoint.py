import json
import os
import sys
import signal
from unittest.mock import patch

redbotName: str = os.environ.get("NAME") or "redbot"
storageType: str = os.environ.get("STORAGE_TYPE") or "JSON"
basePath: str = os.environ.get("BASE_PATH") or "/config"
dataPath: str = os.environ.get("DATA_PATH") or f'{basePath}/data'
configPath: str = os.environ.get("CONFIG_PATH") or f'{basePath}/config'
os.makedirs(dataPath, exist_ok=True)
os.makedirs(configPath + "/Red-DiscordBot", exist_ok=True)

# Stage 1: redbot-setup

def pgConfig():
    if storageType == "Postgres": return {
        "host": os.environ.get("PGHOST") or "db",
        "port": int(os.environ.get("PGPORT") or int(5432)),
        "user": os.environ.get("PGUSER") or "redbot",
        "password": os.environ.get("PGPASSWORD") or "redbot",
        "database": os.environ.get("PGDB") or "redbot"
    }
    else: return {}

redbotConfig: object = {
    redbotName: {
        "DATA_PATH": dataPath,
        "COG_PATH_APPEND": os.environ.get("COG_PATH_APPEND") or "cogs",
        "CORE_PATH_APPEND": os.environ.get("CORE_PATH_APPEND") or "core",
        "STORAGE_TYPE": storageType,
        "STORAGE_DETAILS": pgConfig()
    }
}

with open(configPath + "/Red-DiscordBot/config.json", "w", encoding="utf-8") as f:
    json.dump(redbotConfig, f, ensure_ascii=True, indent=4)

# Stage 2: redbot

def redbotRun(args: list):
    runArgs: list = ["", redbotName]
    runArgs.extend(args)
    print(runArgs)
    with patch.object(sys, 'argv', runArgs):
        try:
            os.environ["XDG_CONFIG_HOME"] = configPath
            from redbot.__main__ import main # importing before the env var overwrite won't propagate the env var to the imported function
            main()
        except SystemExit:
            return

prefixList: list = ["--edit", "--no-prompt"]
def prefixAppend(prefix: str):
    prefixList.extend(["--prefix", prefix])
if os.environ.get("PREFIX"): prefixAppend(os.environ.get("PREFIX"))
if os.environ.get("PREFIXES"): 
    for p in os.environ.get("PREFIXES").strip().split(): prefixAppend(p)
redbotRun(prefixList)

def readFileOrEnv(file: str, env: str):
    if os.environ.get(file) is not None:
        with open(os.environ.get(file), "r", encoding="utf-8") as f: return f.read()
    else: return os.environ.get(env)
redbotRun(["--edit", "--no-prompt", "--token", readFileOrEnv("TOKEN_FILE", "TOKEN")])
if os.environ.get("OWNER") or os.environ.get("OWNER_FILE"): redbotRun(["--edit", "--no-prompt", "--owner", readFileOrEnv("OWNER_FILE", "OWNER")])

sys.exit(redbotRun([]))
