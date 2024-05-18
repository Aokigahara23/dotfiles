#!/bin/bash

set -e

# Check if path and project name were provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 /path/to/project project_name"
    exit 1
fi

# Get the target path and project name from the arguments
TARGET_PATH="$1"
PROJECT_NAME="$2"

# Create the target directory if it does not exist
if [ ! -d "$TARGET_PATH" ]; then
    mkdir -p "$TARGET_PATH"
fi

# Check if the src directory already exists
if [ -d "$TARGET_PATH/src" ]; then
    echo "Error: src directory already exists at $TARGET_PATH/src"
    exit 1
fi

# Define file contents using the project name
CMAKELISTS_CONTENT=`cat <<EOF
cmake_minimum_required(VERSION 3.22)
project(${PROJECT_NAME})

# Set standart and specify toolchain path
set(CMAKE_CXX_STANDARD 17)
include(./toolchain.cmake)

# Specify source code directory and add executable
file(GLOB SOURCE_CODE "src/*.h" "src/*.cpp")
add_executable(${PROJECT_NAME} \\${SOURCE_CODE})

# Tests
file(GLOB TESTS_CODE "tests/*.h" "tests/*.cpp")
# configure Catch2
find_package(Catch2 3 REQUIRED)
# These tests can use the Catch2-provided main
add_executable(tests \\${TESTS_CODE})
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)
EOF
`

TOOLCHAIN_CONTENT=`cat <<EOF
# Specify the cross-compilation toolchain
set(CMAKE_SYSTEM_NAME Linux) # Target system
set(CMAKE_SYSTEM_PROCESSOR amd64) # Target processor

# Specify the compiler
set(CMAKE_C_COMPILER clang) # Path to your C compiler
set(CMAKE_CXX_COMPILER clang++) # Path to your C++ compiler
EOF
`

CLANGD_CONTENT=`cat <<EOF
Diagnostics:
  Suppress: enum-constexpr-conversion
EOF
`

CLANG_TIDY_CONTENT=`cat <<EOF
---
Checks: "clang-diagnostic-*,
  clang-analyzer-*,
  modernize-use-override,
  readability-identifier-naming,
  -cert-err60-cpp"

WarningsAsErrors: ""
HeaderFilterRegex: ""
AnalyzeTemporaryDtors: false
FormatStyle: none
User: alexander.petrov + danil.kovalev
CheckOptions:
  - key: cert-dcl16-c.NewSuffixes
    value: "L;LL;LU;LLU"
  - key: cert-oop54-cpp.WarnOnlyIfThisHasSuspiciousField
    value: "0"
  - key: cppcoreguidelines-explicit-virtual-functions.IgnoreDestructors
    value: "1"
  - key: cppcoreguidelines-non-private-member-variables-in-classes.IgnoreClassesWithAllMemberVariablesBeingPublic
    value: "1"
  - key: google-readability-braces-around-statements.ShortStatementLines
    value: "1"
  - key: google-readability-function-size.StatementThreshold
    value: "800"
  - key: google-readability-namespace-comments.ShortNamespaceLines
    value: "10"
  - key: google-readability-namespace-comments.SpacesBeforeComments
    value: "2"
  - key: modernize-loop-convert.MaxCopySize
    value: "16"
  - key: modernize-loop-convert.MinConfidence
    value: reasonable
  - key: modernize-loop-convert.NamingStyle
    value: CamelCase
  - key: modernize-pass-by-value.IncludeStyle
    value: llvm
  - key: modernize-replace-auto-ptr.IncludeStyle
    value: llvm
  - key: modernize-use-nullptr.NullMacros
    value: "NULL"
  # Code style
  - key: readability-identifier-naming.ClassCase
    value: "CamelCase"
  - key: readability-identifier-naming.ClassPrefix
    value: "C"
  - key: readability-identifier-naming.AbstractClassCase
    value: "ClassPrefix"
  - key: readability-identifier-naming.AbstractClassPrefix
    value: "I"
  - key: readability-identifier-naming.StructCase
    value: "CamelCase"
  - key: readability-identifier-naming.StructPrefix
    value: "S"
  #  Class member rules
  - key: readability-identifier-naming.PrivateMemberCase
    value: "camelBack"
  - key: readability-identifier-naming.PrivateMemberPrefix
    value: "m_"
  - key: readability-identifier-naming.PublicMemberCase
    value: "camelBack"
  # Commented because struct members take same rule
  #  - key: readability-identifier-naming.PublicMemberPrefix
  #    value: 'm_'
  - key: readability-identifier-naming.ClassMemberCase
    value: "camelBack"
  - key: readability-identifier-naming.ClassMemberPrefix
    value: "s_"
  #  Class methods rules
  - key: readability-identifier-naming.ClassMethodCase
    value: "CamelCase"
  - key: readability-identifier-naming.FunctionCase
    value: "CamelCase"
  #  Variable rules
  - key: readability-identifier-naming.VariableCase
    value: "camelBack"
  - key: readability-identifier-naming.LocalVariableCase
    value: "camelBack"
  # For global variables
  - key: readability-identifier-naming.GlobalConstantCase
    value: "CamelCase"
  - key: readability-identifier-naming.GlobalConstantPointerCase
    value: "CamelCase"
#  - key: readability-identifier-naming.GlobalPointerCase
#      value: 'CamelCase'
#  - key: readability-identifier-naming.GlobalVariableCase
#    value: 'CamelCase'
EOF
`

CLANG_FORMAT_CONTENT=`cat <<EOF
---
# https://clang.llvm.org/docs/ClangFormatStyleOptions.html
BasedOnStyle: WebKit
Language: Cpp
AlignAfterOpenBracket: Align
AlignConsecutiveDeclarations: false
AlignConsecutiveMacros: true
AlignEscapedNewlines: Left
AlignOperands: AlignAfterOperator
AlignTrailingComments: true
AllowAllArgumentsOnNextLine: false
AllowAllConstructorInitializersOnNextLine: false
AllowAllParametersOfDeclarationOnNextLine: false
AllowShortBlocksOnASingleLine: Never
AllowShortCaseLabelsOnASingleLine: false
AllowShortEnumsOnASingleLine: false
AllowShortFunctionsOnASingleLine: None
AllowShortIfStatementsOnASingleLine: false
AllowShortLambdasOnASingleLine: Empty
AllowShortLoopsOnASingleLine: false
AlwaysBreakAfterDefinitionReturnType: None
AlwaysBreakAfterReturnType: None
AlwaysBreakBeforeMultilineStrings: false
AlwaysBreakTemplateDeclarations: Yes
BinPackArguments: true
BinPackParameters: true
# BitFieldColonSpacing: None
BreakBeforeBinaryOperators: All
BreakBeforeBraces: Custom
BraceWrapping:
  AfterCaseLabel: true
  AfterClass: true
  AfterControlStatement: true
  AfterEnum: true
  AfterFunction: true
  AfterNamespace: true
  AfterObjCDeclaration: true
  AfterStruct: true
  AfterUnion: true
  AfterExternBlock: true
  BeforeCatch: true
  BeforeElse: true
  BeforeLambdaBody: true
  BeforeWhile: true
  IndentBraces: false
  SplitEmptyFunction: true
  SplitEmptyRecord: false
  SplitEmptyNamespace: false
BreakBeforeTernaryOperators: true
BreakConstructorInitializers: BeforeComma
BreakInheritanceList: BeforeComma
BreakStringLiterals: false
ColumnLimit: 120
CommentPragmas: "^ IWYU pragma:"
CompactNamespaces: false
ConstructorInitializerAllOnOneLineOrOnePerLine: false
ConstructorInitializerIndentWidth: 4
ContinuationIndentWidth: 2
Cpp11BracedListStyle: true
DerivePointerAlignment: false
DisableFormat: false
# FixNamespaceComments: true
ForEachMacros: [foreach, Q_FOREACH, BOOST_FOREACH]
IncludeCategories:
  - Regex: '^".*_config.h"$'
    Priority: -2
  - Regex: '^"(stdafx|PrecompiledHeader)'
    Priority: -1
  - Regex: "^<([a-zA-Z0-9_]+.*)>$"
    Priority: 1
  - Regex: "^<([.]+.*)>$"
    Priority: 2
  - Regex: ".*"
    Priority: 3
IncludeBlocks: Regroup
IndentCaseBlocks: true
IndentCaseLabels: false
IndentExternBlock: AfterExternBlock
IndentGotoLabels: true
IndentPPDirectives: AfterHash
IndentWidth: 4
IndentWrappedFunctionNames: true
KeepEmptyLinesAtTheStartOfBlocks: false
MaxEmptyLinesToKeep: 1
# NamespaceIndentation should be 'Inner', but it works bad for one-level namespaces
NamespaceIndentation: All
PointerAlignment: Left
# ReflowComments: true
SortIncludes: true
SpaceAfterCStyleCast: false
SpaceAfterLogicalNot: false
SpaceAfterTemplateKeyword: false
SpaceBeforeAssignmentOperators: true
SpaceBeforeCpp11BracedList: false
SpaceBeforeCtorInitializerColon: true
SpaceBeforeInheritanceColon: true
SpaceBeforeParens: ControlStatements
SpaceBeforeRangeBasedForLoopColon: false
SpaceBeforeSquareBrackets: false
SpaceInEmptyBlock: false
SpaceInEmptyParentheses: false
SpacesBeforeTrailingComments: 1
SpacesInAngles: false
SpacesInCStyleCastParentheses: false
SpacesInConditionalStatement: false
SpacesInContainerLiterals: false
SpacesInParentheses: false
SpacesInSquareBrackets: false
Standard: c++17
TabWidth: 4
UseTab: Never
EOF
`

MAIN_CPP_CONTENT=`cat <<EOF
#include <iostream>

int main()
{
    std::cout << "Hello, ${PROJECT_NAME}!" << std::endl;
    return 0;
}
EOF
`

TESTS_CPP_CONTENT=`cat <<EOF
#include <catch2/catch_test_macros.hpp>
#include <catch2/matchers/catch_matchers.hpp>

TEST_CASE("Test test", "[test]")
{
    CHECK(true);
}
EOF
`

BUILD_CONTENT=`cat <<EOF
rm -rf ./build
cmake -DCMAKE_TOOLCHAIN_FILE=toolchain.cmake -B build -S .
cmake --build build
EOF
`

# Define project structure and associated content
declare -A project_files
project_files=(
    ["cbuild.sh"]="$BUILD_CONTENT"
    ["CMakeLists.txt"]="$CMAKELISTS_CONTENT"
    ["toolchain.cmake"]="$TOOLCHAIN_CONTENT"
    [".clangd"]="$CLANGD_CONTENT"
    [".clang-tidy"]="$CLANG_TIDY_CONTENT"
    [".clang-format"]="$CLANG_FORMAT_CONTENT"
    ["src/main.cpp"]="$MAIN_CPP_CONTENT"
    ["tests/test.cpp"]="$TESTS_CPP_CONTENT"
)

# Create directories and files with specified content
for item in "${!project_files[@]}"; do
    # Compute the full path for the item
    full_path="$TARGET_PATH/$item"
    
    # Check if the item is a file within a directory
    if [[ "$item" == */* ]]; then
        dir=$(dirname "$full_path")
        file=$(basename "$full_path")

        # Create directory if it doesn't exist
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
        fi

        # Create file with specified content
        echo "${project_files[$item]}" > "$dir/$file"
    else
        # Create file with specified content
        echo "${project_files[$item]}" > "$full_path"
    fi
done

echo "C++ project template created successfully at $TARGET_PATH with project name $PROJECT_NAME."

