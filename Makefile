OUTPUT_DIR := ./build
TEX_OUTPUT_DIR := ./build/tex_output/
MD_FILE := ./N150_Image_Backup_Restore_Instruction.md
MD_PDF := $(OUTPUT_DIR)/N150_Image_Backup_Restore_Instruction.pdf
MD_TEX_PDF := $(TEX_OUTPUT_DIR)/N150_Image_Backup_Restore_Instruction.pdf
TEX_FILE := $(OUTPUT_DIR)/N150_Image_Backup_Restore_Instruction.tex

all:$(MD_PDF) $(TEX_FILE) $(MD_TEX_PDF)

$(MD_PDF):$(MD_FILE)

$(TEX_FILE):$(MD_FILE)

$(OUTPUT_DIR)/%.pdf:%.md
	@mkdir -p $(OUTPUT_DIR)
	pandoc $< \
	--from markdown-implicit_figures \
	--resource-path=.:./pictures/ \
	--pdf-engine=xelatex \
	-V floatplacement=H \
	-V figurePosition=H \
	-V mainfont="Microsoft YaHei" \
	-V CJKmainfont="Noto Serif CJK SC" \
	-V fontsize=12pt \
	-V geometry:"a4paper, margin=2.5cm" \
	-o $@


$(OUTPUT_DIR)/%.tex:%.md
	@mkdir -p $(OUTPUT_DIR)
	pandoc $< -s  --pdf-engine=xelatex \
	-V CJKmainfont="Noto Serif CJK SC" \
	-o $(TEX_FILE)

$(TEX_OUTPUT_DIR)/%.pdf:$(OUTPUT_DIR)/%.tex
	@mkdir -p $(TEX_OUTPUT_DIR)
	xelatex -halt-on-error --output-directory=$(TEX_OUTPUT_DIR) $< 
	

.PHONEY:share clean

share:
	$(RM) ~/share/*.pdf
	@cp -fv $(MD_PDF) ~/share/
clean:
	$(RM) $(OUTPUT_DIR)/*.pdf
	$(RM) $(TEX_OUTPUT_DIR)/*.pdf

	
