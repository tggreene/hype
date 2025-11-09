#!/usr/bin/env python3

"""
Script to automatically sync Swift files in Hype/ directory to Xcode project.
Adds any Swift files that aren't already in the project.
"""

import re
import uuid
import sys
import os
from pathlib import Path

def generate_uuid():
    """Generate a 24-character hex UUID like Xcode uses"""
    return ''.join([format(b, '02X') for b in uuid.uuid4().bytes[:12]])

def find_swift_files(hype_dir):
    """Find all Swift files in Hype directory (excluding subdirectories)"""
    swift_files = []
    for file in Path(hype_dir).iterdir():
        if file.is_file() and file.suffix == '.swift':
            swift_files.append(file)
    return sorted(swift_files)

def get_files_in_project(project_file):
    """Extract Swift file names already in the project"""
    with open(project_file, 'r') as f:
        content = f.read()

    # Find all Swift file references
    pattern = r'/\* ([^/]+\.swift) \*/'
    files = set(re.findall(pattern, content))
    return files

def add_file_to_project(project_file, swift_file):
    """Add a Swift file to the Xcode project"""
    filename = swift_file.name

    with open(project_file, 'r') as f:
        content = f.read()

    # Generate UUIDs
    file_ref_uuid = generate_uuid()
    build_file_uuid = generate_uuid()

    # 1. Add PBXFileReference
    file_ref_pattern = r'(/\* Begin PBXFileReference section \*/\n)'
    file_ref_entry = f'\t\t{file_ref_uuid} /* {filename} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = {filename}; sourceTree = "<group>"; }};\n'
    content = re.sub(file_ref_pattern, r'\1' + file_ref_entry, content)

    # 2. Add PBXBuildFile
    build_file_pattern = r'(/\* Begin PBXBuildFile section \*/\n)'
    build_file_entry = f'\t\t{build_file_uuid} /* {filename} in Sources */ = {{isa = PBXBuildFile; fileRef = {file_ref_uuid} /* {filename} */; }};\n'
    content = re.sub(build_file_pattern, r'\1' + build_file_entry, content)

    # 3. Add to PBXGroup (Hype group)
    group_pattern = r'(94B6CF212B13398E00C1CF46 /\* Hype \*/ = \{[^}]+children = \(\n)([^)]+)(\t\t\);)'
    group_entry = f'\t\t\t\t{file_ref_uuid} /* {filename} */,\n'
    def add_to_group(match):
        return match.group(1) + match.group(2) + group_entry + match.group(3)
    content = re.sub(group_pattern, add_to_group, content, flags=re.DOTALL)

    # 4. Add to PBXSourcesBuildPhase
    sources_pattern = r'(94B6CF1D2B13398E00C1CF46 /\* Sources \*/ = \{[^}]+files = \(\n)([^)]+)(\t\t\);)'
    sources_entry = f'\t\t\t\t{build_file_uuid} /* {filename} in Sources */,\n'
    def add_to_sources(match):
        return match.group(1) + match.group(2) + sources_entry + match.group(3)
    content = re.sub(sources_pattern, add_to_sources, content, flags=re.DOTALL)

    # Write back
    with open(project_file, 'w') as f:
        f.write(content)

    return True

def main():
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    hype_dir = project_root / "Hype"
    project_file = project_root / "Hype.xcodeproj" / "project.pbxproj"

    if not project_file.exists():
        print(f"❌ Error: Xcode project file not found: {project_file}")
        sys.exit(1)

    if not hype_dir.exists():
        print(f"❌ Error: Hype directory not found: {hype_dir}")
        sys.exit(1)

    print("🔍 Scanning for Swift files in Hype/ directory...")
    print("")

    swift_files = find_swift_files(hype_dir)
    if not swift_files:
        print("✅ No Swift files found in Hype/ directory")
        sys.exit(0)

    files_in_project = get_files_in_project(project_file)
    files_to_add = [f for f in swift_files if f.name not in files_in_project]

    if not files_to_add:
        print("✅ All Swift files are already in the Xcode project")
        sys.exit(0)

    print(f"📝 Found {len(files_to_add)} file(s) to add:")
    for file in files_to_add:
        print(f"   - {file.name}")
    print("")

    # Ask for confirmation
    response = input("Add these files to the Xcode project? [y/N] ")
    if response.lower() != 'y':
        print("❌ Cancelled")
        sys.exit(0)

    print("")
    print("📥 Adding files to Xcode project...")

    for file in files_to_add:
        try:
            add_file_to_project(project_file, file)
            print(f"✅ Added: {file.name}")
        except Exception as e:
            print(f"❌ Error adding {file.name}: {e}")
            sys.exit(1)

    print("")
    print("✅ Done! Files have been added to the Xcode project.")
    print("💡 You may need to close and reopen Xcode for changes to appear.")

if __name__ == "__main__":
    main()
