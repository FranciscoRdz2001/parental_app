package com.example.parental_app

import android.annotation.SuppressLint
import android.app.usage.UsageStatsManager
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.net.Uri
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.parental_app/apps_history"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            when(call.method){
                "getAppsHistory" -> getAppsHistory(result)
            }
        }
    }


    private fun  getAppsHistory(result: MethodChannel.Result){
        grantUsagePermission()
        val calendar: Calendar = Calendar.getInstance()
        calendar.add(Calendar.MONTH, -1)
        val usageStatsManager = activity.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        val start: Long = calendar.timeInMillis
        val end = System.currentTimeMillis()
        val stats = usageStatsManager.queryUsageStats(0, start, end)
        val data = stats.map { e ->

            var app : ApplicationInfo? = null
            var name : String?= null
            try {
                app =  activity.packageManager.getApplicationInfo(e.packageName, 0)
                name = activity.packageManager.getApplicationLabel(app)?.toString()
            } catch (e : Exception){
                app = null
            }
            if(name == null){
                try {
                    name = activity.getString(app!!.labelRes)
                } catch (ex : Exception){
                    name = "Sin nombre ${e.packageName}"
                }
            }
            mapOf(
                "name" to  name,
                "packageName" to app?.packageName,
                "time" to e.lastTimeForegroundServiceUsed,
            )
        }
        result.success(data)
    }

    private fun grantUsagePermission() {
            try {
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                intent.data = Uri.parse("package:" + context.packageName);
                context.startActivity(intent)
            } catch (e: Exception) {
                val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(intent)
            }
    }
}
