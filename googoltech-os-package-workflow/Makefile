TEX_FILE := $(shell find ./ -maxdepth 1 -type f -name "*.tex")
OUTPUT_DIR := ./build
PDF_FILE := $(patsubst %.tex, %.pdf, $(TEX_FILE))
PDF_FILE := $(addprefix $(OUTPUT_DIR)/,$(PDF_FILE))
PNG_FILE := $(patsubst %.pdf, %.png, $(PDF_FILE))

all:$(PDF_FILE) $(PNG_FILE)

$(OUTPUT_DIR)/%.pdf: %.tex
	@mkdir -p $(OUTPUT_DIR)
	pdflatex -halt-on-error -output-directory=$(OUTPUT_DIR) $<

$(OUTPUT_DIR)/%.png: $(OUTPUT_DIR)/%.pdf
	@pdftoppm -png -r 300 $< $(basename $<)
	@mv -fv $(basename $<)-1.png $@
	@cp $@ ../pictures/

.PHONEY: clean debug share
clean:
	$(RM) $(OUTPUT_DIR)/*
debug:
	@echo $(PDF_FILE)
share:
	@cp -fv $(PDF_FILE) ~/share/
	@cp -fv $(PNG_FILE) ~/share/
