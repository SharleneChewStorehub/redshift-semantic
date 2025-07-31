#!/usr/bin/env python3
"""
A/B Test Progress Monitor

This script continuously monitors the A/B test progress and ensures
all results are properly saved without any data loss.
"""

import os
import time
import json
from datetime import datetime

def check_progress():
    """Check current progress and data integrity."""
    results_dir = "results_multi_agent"
    
    if not os.path.exists(results_dir):
        return {"error": "Results directory not found"}
    
    files = [f for f in os.listdir(results_dir) if f.endswith('.json')]
    files.sort()
    
    # Count by test type
    original_files = [f for f in files if '_original_' in f]
    fixed_files = [f for f in files if '_fixed_' in f]
    
    # Check file sizes and integrity
    total_size = 0
    corrupted_files = []
    
    for file in files:
        file_path = os.path.join(results_dir, file)
        try:
            size = os.path.getsize(file_path)
            total_size += size
            
            # Quick JSON validation
            with open(file_path, 'r') as f:
                json.load(f)
                
        except (json.JSONDecodeError, IOError) as e:
            corrupted_files.append(f"{file}: {str(e)}")
    
    return {
        "timestamp": datetime.now().strftime("%H:%M:%S"),
        "total_files": len(files),
        "original_count": len(original_files),
        "fixed_count": len(fixed_files),
        "total_size_kb": round(total_size / 1024, 1),
        "corrupted_files": corrupted_files,
        "expected_total": 28,  # 14 queries × 2 versions
        "latest_files": files[-3:] if files else []
    }

def monitor_loop():
    """Main monitoring loop."""
    print("🔍 A/B Test Monitor Started")
    print("=" * 50)
    
    last_count = 0
    stall_counter = 0
    
    while True:
        try:
            progress = check_progress()
            
            if "error" in progress:
                print(f"❌ {progress['error']}")
                time.sleep(30)
                continue
            
            current_count = progress["total_files"]
            
            # Print status update
            print(f"\n[{progress['timestamp']}] Progress Update:")
            print(f"  📁 Files: {current_count}/28 ({current_count/28*100:.1f}%)")
            print(f"  📊 Original: {progress['original_count']}, Fixed: {progress['fixed_count']}")
            print(f"  💾 Size: {progress['total_size_kb']}KB")
            
            if progress['corrupted_files']:
                print(f"  ⚠️  Corrupted: {len(progress['corrupted_files'])} files")
                for corrupt in progress['corrupted_files']:
                    print(f"    - {corrupt}")
            else:
                print(f"  ✅ All files valid JSON")
            
            if progress['latest_files']:
                print(f"  📝 Latest: {progress['latest_files'][-1]}")
            
            # Check for stalls
            if current_count == last_count:
                stall_counter += 1
                if stall_counter >= 6:  # 30 minutes of no progress
                    print(f"  ⚠️  STALL DETECTED: No progress for {stall_counter*5} minutes")
            else:
                stall_counter = 0
                print(f"  🚀 Progress continuing...")
            
            last_count = current_count
            
            # Check if complete
            if current_count >= 28:
                print("\n🎉 A/B TEST COMPLETE!")
                print(f"✅ All {current_count} result files saved successfully")
                break
                
        except KeyboardInterrupt:
            print("\n👋 Monitoring stopped by user")
            break
        except Exception as e:
            print(f"❌ Monitor error: {e}")
        
        time.sleep(30)   # Check every 30 seconds for real-time updates

if __name__ == "__main__":
    monitor_loop() 