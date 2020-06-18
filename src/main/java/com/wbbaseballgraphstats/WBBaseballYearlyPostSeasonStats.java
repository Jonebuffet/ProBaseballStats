/**
 * 
 */
package com.wbbaseballgraphstats;

import com.google.common.collect.ImmutableMap;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;
/**
 * @author johnwalker
 *
 */
public class WBBaseballYearlyPostSeasonStats {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 // A SparkSession
        SparkSession spark = SparkSession
          .builder()
          .appName("Datastax Java example")
          .config("spark.cassandra.connection.host", "127.0.0.1")
          .config("spark.cassandra.output.consistency.level", "LOCAL_ONE")
          .master("local[2]")
          .getOrCreate();
        
        System.out.println("Data read as DataSet (DataFrame)");
        
        // Read data as DataSet (DataFrame)
        Dataset<Row> playerinfoset = spark
        	      .read()
        	      .format("org.apache.spark.sql.cassandra")
        	      .options(ImmutableMap.of("table", "player_batting_post_season_by_year", "keyspace", "ks_baseball"))
        	      .load();
        
        System.out.println("Data read as DataSet (DataFrame)");
        
        // Batting Average = h/ab
        Dataset<Row> playerbattingavg = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"), playerinfoset.col("round"),
        											playerinfoset.col("hits").divide(playerinfoset.col("ab"))).withColumnRenamed("(hits / ab)", "batting_avg");
        
        // Writing batting average data into the database.
        playerbattingavg.write()
        				.format("org.apache.spark.sql.cassandra")
        				.options(ImmutableMap.of("table", "player_batting_post_season_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
        				.save();
        
        // Slugging Percentage:SLG = (1B + (2 * 2B) + (3 * 3B) + (4 + 4B))/AB
        Dataset<Row> playersluggingpct = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"), playerinfoset.col("round"),
    			playerinfoset.col("hits").minus(playerinfoset.col("doubles")).minus(playerinfoset.col("triples")).minus(playerinfoset.col("hr"))
    			.plus(playerinfoset.col("doubles").multiply(2))
    			.plus(playerinfoset.col("triples").multiply(3))
    			.plus(playerinfoset.col("hr").multiply(4)).divide(playerinfoset.col("ab")))
        		.withColumnRenamed("(((((((hits - doubles) - triples) - hr) + (doubles * 2)) + (triples * 3)) + (hr * 4)) / ab)", "slg");
        

        // Writing slugging percentage into the database.
        playersluggingpct.write()
        				.format("org.apache.spark.sql.cassandra")
        				.options(ImmutableMap.of("table", "player_batting_post_season_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
        				.save();

        spark.stop();
        System.exit(0);

	}

}
