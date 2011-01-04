<ul>
<%
java.lang.String[] countries = {"Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua & Barbuda", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan",
		"Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan", "Bolivia", "Bosnia & Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burma (Myanmar)", "Burundi",
		"Cambodia", "Cameroon", "Canada", "Cape Verde", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Congo", "Costa Rica", "Cote d'Ivoire", "Croatia", "Cuba", "Cyprus", "Czech Republic",
		"Denmark", "Djibouti", "Dominican Republic",
		"Ecuador", "East Timor", "Egypt", "El Salvador", "England", "Equatorial Guinea", "Estonia", "Ethiopia",
		"Fiji", "Finland", "France",
		"Gabon", "Gambia", "Germany", "Ghana", "Great Britain", "Greece", "Greenland", "Grenada", "Guatemala", "Guinea", "Guyana", 
		"Haiti", "Honduras", "Hungary",
		"Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy",
		"Jamaica", "Japan", "Jordan",
		"Kazakhstan", "Kenya", "Kiribati", "North Korea", "South Korea", "Kuwait", "Kyrgyzstan",
		"Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg",
		"Macedonia", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar",
		"Namibia", "Nepal", "The Netherlands", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Norway", "Northern Ireland",
		"Oman",
		"Pakistan", "Palau", "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal",
		"Qatar",
		"Romania", "Russia", "Rwanda",
		"St. Lucia", "St. Vincent & The Grenadines", "Samoa", "San Marino", "Sao Tome & Principe", "Saudi Arabia", "Scotland", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "Spain", "Sri Lanka", "Sudan", "Suriname", "Swaziland", "Sweden", "Switzerland", "Syria",
		"Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Tonga", "Trinidad & Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu",
		"Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan",
		"Vanuatu", "Vatican City", "Venezuela", "Vietnam",
		"Western Sahara", "Wales",
		"Yemen",
		"Zaire", "Zambia", "Zimbabwe"};
for (String country : countries) {
    if (country.toLowerCase().startsWith(request.getParameter("sofar").toLowerCase())) {
%><li><%= country %></li>
<%
    }
}
%>
</ul>


