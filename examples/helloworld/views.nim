import ../../src/prologue


proc hello*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologue!</h1>"

proc docs*(ctx: Context) {.async.} =
  resp staticFileResponse("docs.html", "docs")

proc redocs*(ctx: Context) {.async.} = 
  resp staticFileResponse("redocs.html", "docs")

proc docsjson*(ctx: Context) {.async.} =
  resp staticFileResponse("openapi.json", "docs")

proc home*(ctx: Context) {.async.} =
  echo ctx.request.queryParams.getOrDefault("name", "")
  resp "<h1>Home</h1>"

proc index*(ctx: Context) {.async.} =
  resp staticFileResponse("index.html", "static")

proc helloName*(ctx: Context) {.async.} =
  resp "<h1>Hello, " & ctx.request.pathParams.getOrDefault("name", "Prologue") & "</h1>"

proc testRedirect*(ctx: Context) {.async.} =
  resp redirect("/hello")

proc login*(ctx: Context) {.async.} =
  resp loginPage()

proc do_login*(ctx: Context) {.async.} =
  echo "-----------------------------------------------------"
  echo ctx.request.postParams
  echo ctx.request.postParams.getOrDefault("username", "")
  echo ctx.request.postParams.getOrDefault("password", "")
  resp redirect("/hello/Nim")

proc multiPart*(ctx: Context) {.async.} =
  resp multiPartPage()

proc do_multiPart*(ctx: Context) {.async.} =
  resp redirect("/login")