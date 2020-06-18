// Graph Schema Properties
schema.propertyKey('playerid').Text().ifNotExists().create();
schema.propertyKey('birthyear').Int().ifNotExists().create();
schema.propertyKey('birthmonth').Int().ifNotExists().create();
schema.propertyKey('birthday').Int().ifNotExists().create();
schema.propertyKey('birthcountry').Text().ifNotExists().create();
schema.propertyKey('birthstate').Text().ifNotExists().create();
schema.propertyKey('birthcity').Text().ifNotExists().create();
schema.propertyKey('deathyear').Int().ifNotExists().create();
schema.propertyKey('deathmonth').Int().ifNotExists().create();
schema.propertyKey('deathday').Int().ifNotExists().create();
schema.propertyKey('deathcountry').Text().ifNotExists().create();
schema.propertyKey('deathstate').Text().ifNotExists().create();
schema.propertyKey('deathcountry').Text().ifNotExists().create();
schema.propertyKey('deathstate').Text().ifNotExists().create();
schema.propertyKey('deathcity').Text().ifNotExists().create();
schema.propertyKey('namefirst').Text().ifNotExists().create();
schema.propertyKey('namelast').Text().ifNotExists().create();
schema.propertyKey('namegiven').Text().ifNotExists().create();
schema.propertyKey('weight').Double().ifNotExists().create();
schema.propertyKey('height').Text().ifNotExists().create();
schema.propertyKey('bats').Text().ifNotExists().create();
schema.propertyKey('throws').Text().ifNotExists().create();
schema.propertyKey('debut').Date().ifNotExists().create();
schema.propertyKey('finalgame').Date().ifNotExists().create();
schema.propertyKey('retroid').Text().ifNotExists().create();
schema.propertyKey('bbrefid').Text().ifNotExists().create();


schema.vertexLabel('player_info').
	partitionKey('playerid').
	properties('birthyear', 'birthmonth', 'birthday', 'birthcountry', 'birthstate', 'birthcity', 'deathyear', 'deathmonth', 'deathday', 'deathcountry', 'deathstate', 'deathcity', 'namefirst', 'namelast', 'namegiven', 'weight', 'height', 'bats', 'throws', 'debut', 'finalgame', retroid', bbrefid').
	       ifNotExists().
	       create();
	
// Graph Schema Properties
schema.propertyKey('yearid').Int().ifNotExists().create();
schema.propertyKey('ab').Int().ifNotExists().create();
schema.propertyKey('bb').Int().ifNotExists().create();
schema.propertyKey('cs').Int().ifNotExists().create();
schema.propertyKey('doubles').Int().ifNotExists().create();
schema.propertyKey('games').Int().ifNotExists().create();
schema.propertyKey('gidp').Int().ifNotExists().create();
schema.propertyKey('hbp').Int().ifNotExists().create();
schema.propertyKey('hits').Int().ifNotExists().create();
schema.propertyKey('hr').Int().ifNotExists().create();
schema.propertyKey('batting_avg').Decimal().ifNotExists().create();
schema.propertyKey('ibb').Int().ifNotExists().create();
schema.propertyKey('lgid').Text().ifNotExists().create();
schema.propertyKey('rbi').Int().ifNotExists().create();
schema.propertyKey('runs').Int().ifNotExists().create();
schema.propertyKey('sb').Int().ifNotExists().create();
schema.propertyKey('sf').Int().ifNotExists().create();
schema.propertyKey('sh').Int().ifNotExists().create();
schema.propertyKey('so').Int().ifNotExists().create();
schema.propertyKey('stint').Int().ifNotExists().create();
schema.propertyKey('teamid').Text().ifNotExists().create();
schema.propertyKey('triples').Int().ifNotExists().create();
schema.propertyKey('obp').Decimal().ifNotExists().create();
schema.propertyKey('slg').Decimal().ifNotExists().create();
schema.propertyKey('ops').Decimal().ifNotExists().create();
schema.propertyKey('ops_plus').Decimal().ifNotExists().create();


// Vertex labels
schema.vertexLabel('player_batting_by_year').
       partitionKey('playerid', 'yearid').
       properties('ab', 'bb', 'cs', 'doubles', 'games', 'gidp', 'hbp', 'hits', 'hr', 'batting_avg', 'ibb', 'lgid', 'rbi', 'runs', 'sb', 'sf', 'sh', 'so', 'stint', 'teamid', 'triples', 'obp', 'slg', 'ops', 'ops_plus').
       ifNotExists().
       create();


// Graph Schema Properties
schema.propertyKey('round').Text().ifNotExists().create();

// Vertex labels
schema.vertexLabel('player_batting_post_season_by_year').
       partitionKey('playerid', 'yearid', round).
       properties('ab', 'bb', 'cs', 'doubles', 'games', 'gidp', 'hbp', 'hits', 'hr', 'batting_avg', 'ibb', 'lgid', 'rbi', 'runs', 'sb', 'sf', 'sh', 'so', 'teamid', 'triples', 'obp', 'slg', 'ops', 'ops_plus').
       ifNotExists().
       create();

schema.vertexLabel('order').
       partitionKey('orderid').
       properties('createdtime', 'outcome', 'creditcardhashed', 'ipaddress', 'amount', 'deviceid').
       ifNotExists().
       create();
	   
schema.vertexLabel('chargeback').
       partitionKey('chargebacknumber').
       properties('createdtime', 'amount', 'creditcardhashed').
       ifNotExists().
       create();
schema.vertexLabel('creditCard').
       partitionKey('creditcardhashed').
       properties('type').
       ifNotExists().
       create();
	   
schema.vertexLabel('device').
       partitionKey('deviceid').
       properties('type', 'os', 'osversion').
       ifNotExists().
       create();


// Edge labels
schema.edgeLabel('has_batting_statistics').
       connection('player_info', 'player_batting_by_year').
       ifNotExists().
       create();
schema.edgeLabel('has_post_season_batting_statistics').
       connection('player_info', 'player_batting_post_season_by_year').
       ifNotExists().
       create();
schema.edgeLabel('usesCard').
       connection('order', 'creditCard').
       ifNotExists().
       create();
schema.edgeLabel('chargedWith').
       connection('customer', 'chargeback').
       ifNotExists().
       create();
schema.edgeLabel('fromCard').
       connection('chargeback', 'creditCard').
       ifNotExists().
       create();
schema.edgeLabel('resultsIn').
       connection('order', 'chargeback').
       ifNotExists().
       create();