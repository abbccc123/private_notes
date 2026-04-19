#!/usr/bin/env python3

import sys
import os
from pygments import lexers, token

def audit_file(filename, forbidden_terms):
    try:
        # 根据扩展名获取解析器，无法识别则跳过
        lexer = lexers.get_lexer_for_filename(filename)
    except:
        return

    try:
        with open(filename, 'r', encoding='utf-8', errors='ignore') as f:
            code = f.read()
    except Exception:
        return

    current_line = 1
    # 获取所有的 Token
    try:
        tokens = lexer.get_tokens(code)
    except Exception:
        return
    
    for ttype, value in tokens:
        num_newlines = value.count('\n')
        
        # 审计核心逻辑：
        # 1. 只要是 String 家族的（包括普通串、f-string、单/双引号等）
        # 2. 排除掉明确标记为 Comment 的（虽然 Pygments 已经分得很开了，但这是双重保险）
        # 3. 排除掉 Python 的 Docstrings（如果你觉得类注释不需要审）
        
        is_string = ttype in token.String
        is_comment = ttype in token.Comment
        is_doc = ttype is token.String.Doc
        
        if is_string and not is_comment and not is_doc:
            # 命中测试
            content_lower = value.lower()
            for term in forbidden_terms:
                if term.lower() in content_lower:
                    # 格式化输出：[文件名]:[行号]:[命中词] -> [上下文内容]
                    clean_content = value.strip().replace('\n', ' \\n ')
                    print(f"{filename}:{current_line}: [HIT] '{term}' -> {clean_content}")
        
        # 累加行号
        current_line += num_newlines

if __name__ == "__main__":
    # 配置敏感词（建议全部小写，匹配时也转小写，防止大小写绕过）
    SENSITIVE_WORDS = ["handsome", "internal_only", "confidential"]
    
    # 支持处理文件夹
    targets = sys.argv[1:]
    if not targets:
        print("Usage: python power_audit.py <file_or_dir>")
        sys.exit(1)

    print(f"{abbccc}1233321")

    for target in targets:
        if os.path.isfile(target):
            audit_file(target, SENSITIVE_WORDS)
        elif os.path.isdir(target):
            for root, dirs, files in os.walk(target):
                for file in files:
                    audit_file(os.path.join(root, file), SENSITIVE_WORDS)
