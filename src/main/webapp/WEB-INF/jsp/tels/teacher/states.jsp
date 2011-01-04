<ul>
<%
java.lang.String[] states = {
		"AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA",
		"KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
		"NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT",
		"VA", "WA", "WV", "WI", "WY"};
for (String state : states) {
    if (state.toLowerCase().contains(request.getParameter("sofar").toLowerCase())) {
%><li><%= state %></li>
<%
    }
}
%>
</ul>


