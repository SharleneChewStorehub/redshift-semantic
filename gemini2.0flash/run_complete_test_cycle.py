#!/usr/bin/env python3
"""
Complete Test Cycle Automation - Gemini 2.0 Flash

This script orchestrates the complete testing cycle:
1. Loop 1: RAG Agent Testing
2. Loop 2: Framework Agent Testing  
3. Results summary and analysis

Author: AI Assistant
"""

import os
import sys
import subprocess
import time
from datetime import datetime


def print_banner(text: str, char: str = "=") -> None:
    """Print a formatted banner."""
    print(f"\n{char * 60}")
    print(f"{text.center(60)}")
    print(f"{char * 60}\n")


def run_script(script_name: str, description: str) -> bool:
    """Run a Python script and return success status."""
    print(f"🚀 Starting: {description}")
    print(f"📜 Script: {script_name}")
    
    start_time = time.time()
    
    try:
        # Run the script
        result = subprocess.run([sys.executable, script_name], 
                              capture_output=False, 
                              text=True, 
                              cwd=os.getcwd())
        
        end_time = time.time()
        duration = end_time - start_time
        
        if result.returncode == 0:
            print(f"✅ {description} completed successfully!")
            print(f"⏱️  Duration: {duration:.1f} seconds")
            return True
        else:
            print(f"❌ {description} failed with return code: {result.returncode}")
            return False
            
    except Exception as e:
        print(f"❌ Error running {script_name}: {e}")
        return False


def check_results_directory(dir_name: str) -> bool:
    """Check if results directory exists and has files."""
    if not os.path.exists(dir_name):
        print(f"❌ Results directory {dir_name} not found")
        return False
    
    files = [f for f in os.listdir(dir_name) if f.endswith('.json')]
    file_count = len(files)
    
    print(f"📁 Found {file_count} result files in {dir_name}")
    
    if file_count == 0:
        print(f"⚠️  No JSON result files found in {dir_name}")
        return False
    elif file_count < 14:
        print(f"⚠️  Expected 14 result files, found {file_count}")
        return False
    else:
        print(f"✅ All expected result files present in {dir_name}")
        return True


def validate_environment() -> bool:
    """Validate that environment is ready for testing."""
    print("🔍 Validating environment...")
    
    # Check for required environment variables
    required_vars = ["GOOGLE_API_KEY"]
    missing_vars = []
    
    for var in required_vars:
        if not os.getenv(var):
            missing_vars.append(var)
    
    if missing_vars:
        print(f"❌ Missing required environment variables: {missing_vars}")
        return False
    
    # Check for test scripts
    scripts = ["run_rag_test_2_0_flash.py", "run_framework_test_2_0_flash.py"]
    missing_scripts = []
    
    for script in scripts:
        if not os.path.exists(script):
            missing_scripts.append(script)
    
    if missing_scripts:
        print(f"❌ Missing test scripts: {missing_scripts}")
        return False
    
    # Check for golden queries directory
    if not os.path.exists("../golden_queries"):
        print("❌ Golden queries directory not found at ../golden_queries")
        return False
    
    print("✅ Environment validation passed!")
    return True


def generate_summary() -> None:
    """Generate a summary of test results."""
    print_banner("TEST CYCLE SUMMARY", "🎯")
    
    # Check RAG results
    rag_success = check_results_directory("results_rag")
    
    # Check Framework results  
    framework_success = check_results_directory("results_framework")
    
    # Overall status
    if rag_success and framework_success:
        print("🎉 COMPLETE TEST CYCLE SUCCESSFUL!")
        print("📊 Both RAG and Framework agents have been tested")
        print("📝 Ready for critical audit phase")
    elif rag_success:
        print("⚠️  Partial Success: RAG testing completed, Framework testing issues")
    elif framework_success:
        print("⚠️  Partial Success: Framework testing completed, RAG testing issues")
    else:
        print("❌ Test cycle failed - check logs for details")
    
    print(f"\n📅 Test cycle completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")


def main():
    """Main execution function."""
    print_banner("GEMINI 2.0 FLASH - COMPLETE TEST CYCLE", "🚀")
    
    print("Model: gemini-2.0-flash-exp")
    print("Testing Framework: Loop 1 (RAG) → Loop 2 (Framework)")
    print(f"Start Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Phase 0: Environment validation
    print_banner("PHASE 0: ENVIRONMENT VALIDATION")
    
    if not validate_environment():
        print("❌ Environment validation failed. Please fix issues and retry.")
        return
    
    # Phase 1: RAG Agent Testing (Loop 1)
    print_banner("PHASE 1: RAG AGENT TESTING (LOOP 1)")
    
    rag_success = run_script("run_rag_test_2_0_flash.py", "RAG Agent Testing")
    
    if rag_success:
        check_results_directory("results_rag")
    else:
        print("⚠️  RAG testing failed, but continuing with Framework testing...")
    
    # Small delay between phases
    time.sleep(2)
    
    # Phase 2: Framework Agent Testing (Loop 2)
    print_banner("PHASE 2: FRAMEWORK AGENT TESTING (LOOP 2)")
    
    framework_success = run_script("run_framework_test_2_0_flash.py", "Framework Agent Testing")
    
    if framework_success:
        check_results_directory("results_framework")
    
    # Phase 3: Summary and Next Steps
    generate_summary()
    
    print_banner("NEXT STEPS", "📋")
    print("1. Review test results in results_rag/ and results_framework/")
    print("2. Perform critical audits:")
    print("   - Compare RAG results against golden queries") 
    print("   - Compare Framework results against golden queries")
    print("   - Analyze improvement patterns")
    print("3. Generate audit reports:")
    print("   - LOOP1_RAG_AUDIT_GEMINI_2_0_FLASH.md")
    print("   - LOOP2_FRAMEWORK_AUDIT_GEMINI_2_0_FLASH.md")
    print("4. Compare with Gemini 2.5 Pro results for model analysis")


if __name__ == "__main__":
    main() 