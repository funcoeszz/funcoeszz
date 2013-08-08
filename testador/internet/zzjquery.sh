$ zzjquery
Uso: zzjquery [-s] função
$ zzjquery -s get
- get()
- get(num)
- $.get(url, params, callback)
$ zzjquery get
get():
  Access all matched DOM elements. This serves as a backwards-compatible
  way of accessing all matched elements (other than the jQuery object
  itself, which is, in fact, an array of elements).

get(num):
  Access a single matched DOM element at a specified index in the matched set.
  This allows you to extract the actual DOM element and operate on it
  directly without necessarily using jQuery functionality on it.

$.get(url, params, callback):
  Load a remote page using an HTTP GET request.
$
