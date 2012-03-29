# ----------------------------------------------------------------------------
# Converte caracteres Unicode (UTF-8) para seus similares ASCII (128).
#
# Uso: zzunicode2ascii [arquivo(s)]
# Ex.: zzunicode2ascii arquivo.txt
#      cat arquivo.txt | zzunicode2ascii
#
# Autor: Aurelio Marinho Jargas, www.aurelio.net
# Desde: 2011-05-06
# Versão: 1
# Licença: GPL
# ----------------------------------------------------------------------------
zzunicode2ascii ()
{
	zzzz -h unicode2ascii "$1" && return

	# Tentei manter o sentido do caractere original na tradução.
	# Outros preferi manter o original a fazer um tradução dúbia.
	# Aceito sugestões de melhorias! @oreio

	# Arquivos via STDIN ou argumentos
	zztool file_stdin "$@" | sed "

	# Nota: Mesma tabela de dados da zzunescape.

	# s \" \" g
	# s & & g
	# s ' ' g
	# s < < g
	# s > > g
	# s/ / /g
	s ¡ i g
	s ¢ c g
	# s £ £ g
	# s ¤ ¤ g
	s ¥ Y g
	s ¦ | g
	# s § § g
	s ¨ \" g
	s © (C) g
	s ª a g
	s « << g
	# s ¬ ¬ g
	s ­ - g
	s ® (R) g
	s ¯ - g
	# s ° ° g
	s ± +- g
	s ² 2 g
	s ³ 3 g
	s ´ ' g
	s µ u g
	# s ¶ ¶ g
	s · . g
	s ¸ , g
	s ¹ 1 g
	s º o g
	s » >> g
	s ¼ 1/4 g
	s ½ 1/2 g
	s ¾ 3/4 g
	# s ¿ ¿ g
	s À A g
	s Á A g
	s Â A g
	s Ã A g
	s Ä A g
	s Å A g
	s Æ AE g
	s Ç C g
	s È E g
	s É E g
	s Ê E g
	s Ë E g
	s Ì I g
	s Í I g
	s Î I g
	s Ï I g
	s Ð D g
	s Ñ N g
	s Ò O g
	s Ó O g
	s Ô O g
	s Õ O g
	s Ö O g
	s × x g
	s Ø O g
	s Ù U g
	s Ú U g
	s Û U g
	s Ü U g
	s Ý Y g
	s Þ P g
	s ß B g
	s à a g
	s á a g
	s â a g
	s ã a g
	s ä a g
	s å a g
	s æ ae g
	s ç c g
	s è e g
	s é e g
	s ê e g
	s ë e g
	s ì i g
	s í i g
	s î i g
	s ï i g
	s ð d g
	s ñ n g
	s ò o g
	s ó o g
	s ô o g
	s õ o g
	s ö o g
	s ÷ / g
	s ø o g
	s ù u g
	s ú u g
	s û u g
	s ü u g
	s ý y g
	s þ p g
	s ÿ y g
	s Œ OE g
	s œ oe g
	s Š S g
	s š s g
	s Ÿ Y g
	s ƒ f g
	s ˆ ^ g
	s ˜ ~ g
	s Α A g
	s Β B g
	# s Γ Γ g
	# s Δ Δ g
	s Ε E g
	s Ζ Z g
	s Η H g
	# s Θ Θ g
	s Ι I g
	s Κ K g
	# s Λ Λ g
	s Μ M g
	s Ν N g
	# s Ξ Ξ g
	s Ο O g
	# s Π Π g
	s Ρ P g
	# s Σ Σ g
	s Τ T g
	s Υ Y g
	# s Φ Φ g
	s Χ X g
	# s Ψ Ψ g
	# s Ω Ω g
	s α a g
	s β b g
	# s γ γ g
	# s δ δ g
	s ε e g
	# s ζ ζ g
	s η n g
	# s θ θ g
	# s ι ι g
	s κ k g
	# s λ λ g
	s μ u g
	s ν v g
	# s ξ ξ g
	s ο o g
	# s π π g
	s ρ p g
	s ς s g
	# s σ σ g
	s τ t g
	s υ u g
	# s φ φ g
	s χ x g
	# s ψ ψ g
	s ω w g
	# s ϑ ϑ g
	# s ϒ ϒ g
	# s ϖ ϖ g
	s/ / /g
	s/ / /g
	s/ / /g
	s/‌/ /g
	s/‍/ /g
	s/‎/ /g
	s/‏/ /g
	s – - g
	s — - g
	s ‘ ' g
	s ’ ' g
	s ‚ , g
	s “ \" g
	s ” \" g
	s „ \" g
	# s † † g
	# s ‡ ‡ g
	s • * g
	s … ... g
	# s ‰ ‰ g
	s ′ ' g
	s ″ \" g
	s ‹ < g
	s › > g
	s ‾ - g
	s ⁄ / g
	s € E g
	# s ℑ ℑ g
	# s ℘ ℘ g
	s ℜ R g
	s ™ TM g
	# s ℵ ℵ g
	s ← <- g
	# s ↑ ↑ g
	s → -> g
	# s ↓ ↓ g
	s ↔ <-> g
	# s ↵ ↵ g
	s ⇐ <= g
	# s ⇑ ⇑ g
	s ⇒ => g
	# s ⇓ ⇓ g
	s ⇔ <=> g
	# s ∀ ∀ g
	# s ∂ ∂ g
	# s ∃ ∃ g
	# s ∅ ∅ g
	# s ∇ ∇ g
	# s ∈ ∈ g
	# s ∉ ∉ g
	# s ∋ ∋ g
	# s ∏ ∏ g
	# s ∑ ∑ g
	s − - g
	s ∗ * g
	# s √ √ g
	# s ∝ ∝ g
	# s ∞ ∞ g
	# s ∠ ∠ g
	s ∧ ^ g
	s ∨ v g
	# s ∩ ∩ g
	# s ∪ ∪ g
	# s ∫ ∫ g
	# s ∴ ∴ g
	s ∼ ~ g
	s ≅ ~= g
	s ≈ ~~ g
	# s ≠ ≠ g
	# s ≡ ≡ g
	s ≤ <= g
	s ≥ >= g
	# s ⊂ ⊂ g
	# s ⊃ ⊃ g
	# s ⊄ ⊄ g
	# s ⊆ ⊆ g
	# s ⊇ ⊇ g
	s ⊕ (+) g
	s ⊗ (x) g
	# s ⊥ ⊥ g
	s ⋅ . g
	# s ⌈ ⌈ g
	# s ⌉ ⌉ g
	# s ⌊ ⌊ g
	# s ⌋ ⌋ g
	s ⟨ < g
	s ⟩ > g
	s ◊ <> g
	# s ♠ ♠ g
	# s ♣ ♣ g
	s ♥ <3 g
	s ♦ <> g
	"
}
