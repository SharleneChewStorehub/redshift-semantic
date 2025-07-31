#!/usr/bin/env python3
"""
A/B Test Automation Script

This script automatically runs both versions of the multi-agent test:
1. Test A: Original data catalog (data_catalog.json)
2. Test B: Fixed data catalog (data_catalog_fixed.json)

Author: AI Assistant
"""

import subprocess
import time
import os

def modify_flag_in_script(use_fixed_catalog: bool):
    """Modify the USE_FIXED_CATALOG flag in the multi-agent script."""
    script_path = "run_multi_agent_test.py"
    
    # Read the current script
    with open(script_path, 'r') as file:
        content = file.read()
    
    # Replace the flag
    old_line = f"USE_FIXED_CATALOG = {not use_fixed_catalog}"
    new_line = f"USE_FIXED_CATALOG = {use_fixed_catalog}"
    
    if old_line in content:
        content = content.replace(old_line, new_line)
    else:
        # If exact match not found, replace any USE_FIXED_CATALOG = line
        import re
        content = re.sub(
            r'USE_FIXED_CATALOG = (True|False)', 
            new_line, 
            content
        )
    
    # Write back the modified script
    with open(script_path, 'w') as file:
        file.write(content)
    
    print(f"✓ Set USE_FIXED_CATALOG = {use_fixed_catalog}")

def run_multi_agent_test(test_name: str):
    """Run the multi-agent test and capture the result."""
    print(f"\n🚀 Starting {test_name}...")
    print("=" * 60)
    
    start_time = time.time()
    
    try:
        result = subprocess.run(
            ["python3", "run_multi_agent_test.py"],
            capture_output=True,
            text=True,
            timeout=3600  # 60 minute timeout (increased)
        )
        
        end_time = time.time()
        duration = end_time - start_time
        
        if result.returncode == 0:
            print(f"✅ {test_name} completed successfully in {duration:.1f} seconds")
            print("--- Output ---")
            print(result.stdout[-500:])  # Last 500 chars of output
        else:
            print(f"❌ {test_name} failed with return code {result.returncode}")
            print("--- Error ---")
            print(result.stderr[-500:])
        
        return result.returncode == 0
        
    except subprocess.TimeoutExpired:
        print(f"⏰ {test_name} timed out after 30 minutes")
        return False
    except Exception as e:
        print(f"💥 {test_name} crashed: {str(e)}")
        return False

def main():
    """Run the complete A/B test sequence."""
    print("🧪 Multi-Agent A/B Test Automation")
    print("=" * 50)
    print("This will run both catalog versions and compare results.")
    print("Estimated total time: 30-40 minutes")
    print("Estimated total cost: $4-8")
    print("\n🚀 Starting automated A/B test...")
    
    results = {}
    
    # Test A: Original Catalog
    modify_flag_in_script(False)
    results['original'] = run_multi_agent_test("Test A (Original Catalog)")
    
    # Test B: Fixed Catalog  
    modify_flag_in_script(True)
    results['fixed'] = run_multi_agent_test("Test B (Fixed Catalog)")
    
    # Summary
    print("\n" + "=" * 60)
    print("🏁 A/B Test Complete!")
    print("=" * 60)
    
    print(f"Test A (Original): {'✅ Success' if results['original'] else '❌ Failed'}")
    print(f"Test B (Fixed):    {'✅ Success' if results['fixed'] else '❌ Failed'}")
    
    print(f"\n📂 Results saved in: results_multi_agent/")
    print(f"📊 Compare files ending in '_original_result.json' vs '_fixed_result.json'")
    
    if results['original'] and results['fixed']:
        print("🎉 Both tests completed successfully!")
        print("💡 Next step: Analyze the differences in SQL quality and execution results")
    else:
        print("⚠️  Some tests failed - check the output above for details")

if __name__ == "__main__":
    main() 