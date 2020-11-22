# Crypto-Curl

Crypto-Curl is a shellscript that displays cryptocurrency values (e. g. Bitcoin or Monero) on your polybar and saves a local history to check wheter the average value has risen or fallen.

![Screenshot](/screenshots/screen.png)

It is based on **ticker-crypto** (https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/ticker-crypto)

## Dependencies

- `curl`
- `jq`
- `bc`
- `polybar`
- `Material Icons` (Graphs)
- `Font Awesome Brands (Free)` (Currency Icons)

## Polybare Module Implementation

<pre><code>[module/crypto-curl]
type = custom/script
exec = /path/to/the/crypto-curl.sh [currency]
interval = 600
label-font = <i>[font-index]</i>
label = %output% %{F<i>[#colour]</i>}<i>[icon]</i>%{F-}
</code></pre>