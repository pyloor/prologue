from ../../src/prologue/core/cookies import parseCookie, secondsForward,
    daysForward, timesForward, setCookie


import unittest, strtabs, options, strutils, strformat


suite "Test Cookies":
  test "can parse cookie with one element":
    let tabs = parseCookie("username=flywind ")
    check:
      tabs["username"] == "flywind "

  test "can parse cookie with two elements":
    let tabs = parseCookie("username=flywind; password=root")
    check:
      tabs["username"] == "flywind"
      tabs["password"] == "root"

  test "can parse empty cookies":
    let tabs = parseCookie("")
    check $tabs == $newStringTable()

  test "timesForward can work":
    discard secondsForward(0)
    discard daysForward(10)
    discard timesForward(1, 2, 3, 4, 5, 6, 7, 8)

    # setCookie*(key, value: string, expires = "", maxAge: Option[int] = none(int), domain = "", path = "",
    # secure = false, httpOnly = false, sameSite = Lax)
  test "can set cookies":
    check:
      setCookie("username", "flywind") == "username=flywind; SameSite=Lax"
      setCookie("password", "root", maxAge = some(120)).startsWith("password=root; Max-Age=")

suite "Test Set Cookie":
  let
    username = "admin"
    password = "root"

  test "Key-Value":
    let cookie = setCookie(username, password)
    check cookie == fmt"{username}={password}; SameSite=Lax"

  test "Max-Age":
    let 
      maxAge = 10
      cookie = setCookie(username, password, maxAge = some(maxAge))
    check cookie == fmt"{username}={password}; Max-Age={maxAge}; SameSite=Lax"
