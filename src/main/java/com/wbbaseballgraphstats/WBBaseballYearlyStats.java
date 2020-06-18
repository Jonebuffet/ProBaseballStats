package com.wbbaseballgraphstats;

import com.google.common.collect.ImmutableMap;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

public class WBBaseballYearlyStats 
{
    public static void main( String[] args )
    {
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
        	      .options(ImmutableMap.of("table", "player_batting_by_year", "keyspace", "ks_baseball"))
        	      .load();
        
        System.out.println("Data read as DataSet (DataFrame)");
        
        // Batting Average:BA = H/AB
        Dataset<Row> playerbattingavg = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"),
        											playerinfoset.col("hits").divide(playerinfoset.col("ab"))).withColumnRenamed("(hits / ab)", "batting_avg");
        
        // Writing batting average data into the database.
        playerbattingavg.write()
        				.format("org.apache.spark.sql.cassandra")
        				.options(ImmutableMap.of("table", "player_batting_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
        				.save();
       
        // Slugging Percentage:SLG = (1B + (2 * 2B) + (3 * 3B) + (4 + 4B))/AB
        Dataset<Row> playersluggingpct = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"),
    			playerinfoset.col("hits").minus(playerinfoset.col("doubles")).minus(playerinfoset.col("triples")).minus(playerinfoset.col("hr"))
    			.plus(playerinfoset.col("doubles").multiply(2))
    			.plus(playerinfoset.col("triples").multiply(3))
    			.plus(playerinfoset.col("hr").multiply(4)).divide(playerinfoset.col("ab")))
        		.withColumnRenamed("(((((((hits - doubles) - triples) - hr) + (doubles * 2)) + (triples * 3)) + (hr * 4)) / ab)", "slg");
        

        // Writing slugging percentage into the database.
        playersluggingpct.write()
        				.format("org.apache.spark.sql.cassandra")
        				.options(ImmutableMap.of("table", "player_batting_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
        				.save();
        
        //On Base Percentage:OBP = (H + BB + HBP)/(AB + + BB + HBP + SF)
        Dataset<Row> playerobpct1954 = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"),
     			playerinfoset.col("hits").plus(playerinfoset.col("bb")).plus(playerinfoset.col("hbp"))
     			.divide(playerinfoset.col("ab").plus(playerinfoset.col("bb")).plus(playerinfoset.col("hbp")).plus(playerinfoset.col("sf"))))
        		.filter(playerinfoset.col("yearid").gt(1953))
        		.withColumnRenamed("(((hits + bb) + hbp) / (((ab + bb) + hbp) + sf))", "obp");

        //On Base Percentage:OBP = (H + BB + HBP)/(AB + + BB + HBP)
        /*
         * The sacrifice fly was adopted as an official rule in 1954, at which point it was distinguished from the sacrifice bunt. 
         * Before 1954, Major League Baseball went back and forth as to whether a sacrifice fly should be counted statistically. 
         * In the years that it was counted (1908-31 and '39), it was grouped together with the sacrifice bunt as simply a "sacrifice."
         * 
         * Therefore, the following data set, in calculating On Base Percentage, will be disregarding sacrifice fly data as it is
         * currently only available as a NULL value in the supporting database.
         * 
         */
        //On Base Percentage:OBP = (H + BB + HBP)/(AB + + BB + HBP)
        Dataset<Row> playerobpct1953 = playerinfoset.select( playerinfoset.col("playerid"), playerinfoset.col("yearid"),
     			playerinfoset.col("hits").plus(playerinfoset.col("bb")).plus(playerinfoset.col("hbp"))
     			.divide(playerinfoset.col("ab").plus(playerinfoset.col("bb")).plus(playerinfoset.col("hbp"))))
        		.filter(playerinfoset.col("yearid").lt(1954))
        		.withColumnRenamed("(((hits + bb) + hbp) / ((ab + bb) + hbp))", "obp");

        // Writing OBP data into the database.
        playerobpct1954.write()
    	.format("org.apache.spark.sql.cassandra")
    	.options(ImmutableMap.of("table", "player_batting_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
    	.save(); 

         // Writing OBP data into the database.
        playerobpct1953.write()
    	.format("org.apache.spark.sql.cassandra")
    	.options(ImmutableMap.of("table", "player_batting_by_year", "keyspace", "ks_baseball")).mode(SaveMode.Append)
    	.save(); 

        spark.stop();
        System.exit(0);
        
    }
}
