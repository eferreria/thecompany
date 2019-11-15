```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```


    function fancyAlert(arg) {
      if(arg) {
        $.facebox({div:'#foo'})
      }
    }


Complete Before: {{ complete }}
{% for book in books %}
Title: {{book.Title}}
{% if book.Completed == "true" %}
{% increment completed %}
{% endif %}
{% endfor %}
Complete After: {{ complete }}


<form action="/explore/dev_thecompany/orders" method="get" target="_new">

<br>
<select name="fields" multiple="Yes" size="3">
  <option value="orders.status, ">Order Status </option>
  <option id="op2" value="users.city, "> User City </option>
  <option value="users.state, "> User State</option>
</select>
<br> Hidden Input: Orders Status
<br> <input type="hidden" name="f[users.state]" value="California">

Hidden Filter: Orders=Complete
      <input type="submit" value="Go" name="" style="height:2em; width:100px">
      <input type="reset" value="Reset" name="" style="height:2em; width:100px">
</form>
