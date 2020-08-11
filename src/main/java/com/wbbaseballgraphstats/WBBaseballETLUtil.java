package com.wbbaseballgraphstats;

import java.util.Properties;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SaveMode;
import org.apache.spark.sql.SparkSession;

import com.google.common.collect.ImmutableMap;

public class WBBaseballETLUtil {

	public static void main(String[] args) {
		
		// Write to destination
		String dbConnectionUrl = "jdbc:postgresql://localhost/baseball_alltime_stats"; // <<- You need to create this database
		Properties prop = new Properties();
	    prop.setProperty("driver", "org.postgresql.Driver");
	    prop.setProperty("user", "postgres");
	    prop.setProperty("password", "Maya4Kate!"); // <- The password you used while installing Postgres
	    
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
        System.out.println("=================================================================="); 
        System.out.println("playerinfoset.count() = " + String.valueOf(playerinfoset.count())); 
        System.out.println("==================================================================");
        
        /*
        playerinfoset.write().mode(SaveMode.Overwrite)
    	.jdbc(dbConnectionUrl, "player_batting_post_season_by_year", prop); 
		*/
	}

}
