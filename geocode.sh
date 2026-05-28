#!/usr/bin/env bash
# Nominatim geocoder. 1 req/sec rate limit. Outputs CSV: id,lat,lng,display_name
set -e
UA="freebie-crawl-29/1.0 (events@ecomnorth.com)"
out=geocodes.json
echo '{"places":{' > "$out"
first=1

geo() {
  local id="$1"; local q="$2"
  local r=$(curl -sG "https://nominatim.openstreetmap.org/search" \
    --data-urlencode "q=$q" \
    --data-urlencode "format=json" \
    --data-urlencode "limit=1" \
    --data-urlencode "countrycodes=ca" \
    -H "User-Agent: $UA")
  local lat=$(echo "$r" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d[0]['lat'] if d else '')" 2>/dev/null)
  local lng=$(echo "$r" | python3 -c "import sys,json;d=json.load(sys.stdin);print(d[0]['lon'] if d else '')" 2>/dev/null)
  if [ -z "$lat" ]; then
    echo "MISS $id : $q" >&2
    return
  fi
  if [ $first -eq 0 ]; then echo "," >> "$out"; fi
  first=0
  printf '"%s":{"lat":%s,"lng":%s}' "$id" "$lat" "$lng" >> "$out"
  echo "OK $id $lat,$lng ($q)" >&2
  sleep 1.2
}

geo paris-baguette "110 Bloor Street West, Toronto, ON"
geo toro-toro "675 Yonge Street, Toronto, ON"
geo monga "692 Yonge Street, Toronto, ON"
geo kiehls "220 Yonge Street, Toronto, ON"
geo sephora "220 Yonge Street, Toronto, ON"
geo jollibee "334 Yonge Street, Toronto, ON"
geo cong-caphe "3 Elm Street, Toronto, ON"
geo ten-rens "454 Dundas Street West, Toronto, ON"
geo alley "120 Adelaide Street West, Toronto, ON"
geo chatime "65 Front Street West, Toronto, ON"
geo ikkousha "249 Queen Street West, Toronto, ON"
geo keg "35 The Esplanade, Toronto, ON"
geo krispy "105 Dundas Street East, Toronto, ON"
geo timhortons "277 Yonge Street, Toronto, ON"
geo burgers-priest "579 King Street West, Toronto, ON"
geo red-lobster "20 Dundas Street West, Toronto, ON"
geo boston-pizza "250 Front Street West, Toronto, ON"
geo moxies "70 University Avenue, Toronto, ON"
geo what-a-bagel "130 Spadina Avenue, Toronto, ON"
geo freshii "100 King Street West, Toronto, ON"
geo impact-kitchen "117 King Street West, Toronto, ON"
geo gyubee "157 Dundas Street West, Toronto, ON"
geo afuri "411 Church Street, Toronto, ON"
geo trapped "336 Queen Street West, Toronto, ON"
geo cineplex "259 Richmond Street West, Toronto, ON"
geo clinique "260 Yonge Street, Toronto, ON"
geo wendys "75 Yonge Street, Toronto, ON"
geo harveys "263 Yonge Street, Toronto, ON"
geo nandos "14 Bloor Street East, Toronto, ON"
geo booster-juice "20 Dundas Street West, Toronto, ON"
geo kettlemans "33 Bathurst Street, Toronto, ON"
geo gong-cha "595 Bay Street, Toronto, ON"
geo starbucks "277 Yonge Street, Toronto, ON"
geo gyu-kaku "81 Church Street, Toronto, ON"

echo '}}' >> "$out"
cat "$out"
