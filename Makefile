 # AR PL KaitiM GB,文鼎ＰＬ简中楷
 # AR PL SungtiL GB,文鼎ＰＬ简报宋
 # AR PL UMing CN
 # AR PL UMing HK
 # AR PL UMing TW
 # AR PL UMing TW MBE
 # Noto Sans CJK HK
 # Noto Sans CJK JP
 # Noto Sans CJK KR
 # Noto Sans CJK SC
 # Noto Sans CJK TC
 # Noto Sans Mono CJK HK
 # Noto Sans Mono CJK JP
 # Noto Sans Mono CJK KR
 # Noto Sans Mono CJK SC
 # Noto Sans Mono CJK TC
 # Noto Serif CJK HK
 # Noto Serif CJK JP
 # Noto Serif CJK KR
 # Noto Serif CJK SC
 # Noto Serif CJK TC
 # WenQuanYi Micro Hei Mono,文泉驛等寬微米黑,文泉驿等宽微米黑
 # WenQuanYi Micro Hei,文泉驛微米黑,文泉驿微米黑
 # WenQuanYi Zen Hei Mono,文泉驛等寬正黑,文泉驿等宽正黑
 # WenQuanYi Zen Hei Sharp,文泉驛點陣正黑,文泉驿点阵正黑
 # WenQuanYi Zen Hei,文泉驛正黑,文泉驿正黑
OUTPUT_DIR := ./build
MD_FILE := ./N150_Image_Backup_Restore_Instruction.md
MD_PDF := $(OUTPUT_DIR)/N150_Image_Backup_Restore_Instruction.pdf

all:$(MD_PDF)

$(MD_PDF):$(MD_FILE)

$(OUTPUT_DIR)/%.pdf:%.md
	@mkdir -p $(OUTPUT_DIR)
	pandoc $< --pdf-engine=xelatex -V mainfont="WenQuanYi Micro Hei Mono" -o $@

.PHONEY:move

move:
	@cp $(MD_PDF) ~/share/

	
