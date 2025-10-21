#!/usr/bin/env python3
"""
Demonstration of the GraphQL Schema Generation UX Fix
This script simulates how the fixed behavior would work vs the current problematic behavior.
"""

import os
import time


def simulate_current_behavior():
    """Simulates the current problematic UX behavior"""
    print("🔴 CURRENT PROBLEMATIC BEHAVIOR:")
    print("=" * 50)
    print("User runs: bal graphql -i service.bal -o .")
    print()

    # Simulate processing time
    print("⏳ Tool is generating schema... (processing time wasted)")
    time.sleep(1)  # Simulate processing
    print("✅ Schema generation completed internally")
    print()

    # File conflict check happens AFTER processing
    print("🔍 Tool checks if file exists: schema_graphql.graphql")
    if os.path.exists("schema_graphql.graphql"):
        print(
            "❓ Tool asks: 'There is already a file named 'schema_graphql.graphql' in the target location. Do you want to overwrite the file? [y/N]'")
        user_input = input("Your choice (y/N): ").strip().lower()

        if user_input != 'y':
            print("😤 User said 'No' but tool STILL creates unwanted duplicate file!")
            duplicate_name = "schema_graphql.demo_duplicate.graphql"
            with open(duplicate_name, 'w') as f:
                f.write(
                    "# Unwanted duplicate file created despite user saying 'No'\n# This is the UX problem!\n")
            print(f"❌ Tool created: {duplicate_name}")
            print("✅ Tool says: 'SDL Schema(s) generated successfully...'")
        else:
            print("✅ User agreed, overwriting file...")

    print("\n🚨 PROBLEMS WITH CURRENT BEHAVIOR:")
    print("   - Wasted processing time before asking user")
    print("   - Creates unwanted files even when user says 'No'")
    print("   - Poor UX - doesn't respect user choice")
    print()


def simulate_fixed_behavior():
    """Simulates the improved UX behavior after our fix"""
    print("🟢 FIXED BEHAVIOR (Our Implementation):")
    print("=" * 50)
    print("User runs: bal graphql -i service.bal -o .")
    print()

    # Early file conflict check
    print("⚡ Tool immediately checks if file exists: schema_graphql.graphql")
    if os.path.exists("schema_graphql.graphql"):
        print(
            "❓ Tool asks: 'There is already a file named 'schema_graphql.graphql' in the target location. Do you want to overwrite the file? [y/N]'")
        user_input = input("Your choice (y/N): ").strip().lower()

        if user_input != 'y':
            print("🛑 Tool says: 'Schema generation cancelled by user.'")
            print("🚪 Tool exits immediately - NO processing, NO unwanted files!")
            return
        else:
            print("✅ User agreed, proceeding with schema generation...")
            print("⏳ Tool generates schema... (only when user consents)")
            time.sleep(0.5)  # Simulate processing
            print("✅ Schema generated and file overwritten")
    else:
        print("✅ No file conflict, proceeding with generation...")
        print("⏳ Tool generates schema...")
        time.sleep(0.5)
        print("✅ Schema generated successfully")

    print("\n🎉 BENEFITS OF FIXED BEHAVIOR:")
    print("   - No wasted computation when user declines")
    print("   - Respects user's 'No' choice completely")
    print("   - Better UX - immediate feedback")
    print("   - Clean exit with clear messaging")
    print()


def main():
    print("🧪 GraphQL Schema Generation UX Fix Demonstration")
    print("=" * 60)
    print()

    # Show current behavior
    simulate_current_behavior()

    print("\n" + "="*60 + "\n")

    # Show fixed behavior
    simulate_fixed_behavior()

    print("🎯 CONCLUSION:")
    print("The fix we implemented moves the file conflict check to the BEGINNING")
    print("of the process, eliminating wasted computation and respecting user choice.")


if __name__ == "__main__":
    main()
