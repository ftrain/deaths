from flask import Flask
import sqlite3
import json

app = Flask(__name__)

conn = sqlite3.connect('/Volumes/BWArchive 1/death/deaths.db', check_same_thread=False)
query = 'last:'
fields = ['zza','ssn','last','suffix','first','middle','zzb','dmonth','dday','dyear','bmonth','bday','byear','age']

def row_to_tr(row):
    out = ['<tr>']
    for el in row:
        if el is not None:
            out.append('<td>' + str(el) + '</td>')
        else:
            out.append('<td></td>')
    out.append("</tr>\n")
    return "".join(out)



def row_to_js(row):
    return dict(zip(fields, row))
    
@app.route("/")
def hello():
    c = conn.cursor()
    out = []
    jsons = []    
    results = c.execute("select *, (dyear - byear) from deaths WHERE first MATCH \'" + query + "\' order by byear limit 1000")
    for row in results:
        out.append(row_to_tr(row))
        jsons.append(row_to_js(row))        
    return """<html>
    <head>
    <title>Death Search</title>
    <script src="http://d3js.org/d3.v3.min.js"></script>
    <script>data=""" + json.dumps(jsons,sort_keys=True,indent=4) + """;</script>
    <style type="text/css">
    .chart div {
    font: 14px sans-serif;
    background-color: steelblue;
    text-align: left;
    padding-left:10px;
    margin: 1px;
    margin-bottom:2px;
    color: white;
    }
    table {border-collapse:collapse;} 
    td {border:1px solid black;padding:3px;}</style>
    </head>
    <body>
    <div class="chart"></div>
<script>
    d3.select(".chart")
    .selectAll("div")
    .data(data)
    .enter().append("div")
    .style("width", function(d) { return d.age * 4 + "px"; })
    .style("margin-left", function(d) { return 4 * (d.byear - 1875) + "px"; })
    .text(function(d) { return d.first + " " + d.byear + "-" + d.dyear + " " + d.age; });

</script>
</body></html>"""

        
if __name__ == "__main__":
    app.run(debug=True)



#        for row in c.execute('select first, last, byear, dyear, (dyear - byear) from deaths where first MATCH \'first:paul last:ford\' order by (dyear - byear) limit 10000'):
