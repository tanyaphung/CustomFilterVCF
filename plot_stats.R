library(ggplot2)
library(ggpubr)

args = commandArgs(trailingOnly=TRUE)

stats = read.csv(args[1], sep="\t")

# ---
# AN
# ---
png(args[2], width=8, height=5, units = "in", res = 300)
ggplot(stats, aes(x=AN)) +
  geom_density() +
  theme_bw() +
  theme(axis.text.x = element_text(size=16, colour="black"), axis.text.y = element_text(size=16, colour = "black"), axis.title= element_text(size=16), axis.line=element_line(colour = "black"), axis.ticks = element_line(colour = "black", size=1.5), axis.ticks.length = unit(0.3, 'cm'))

# ---
# QD
# ---
png(args[3], width=8, height=5, units = "in", res = 300)
ggplot(stats, aes(x=QD)) +
  geom_density() +
  theme_bw() +
  theme(axis.text.x = element_text(size=16, colour="black"), axis.text.y = element_text(size=16, colour = "black"), axis.title= element_text(size=16), axis.line=element_line(colour = "black"), axis.ticks = element_line(colour = "black", size=1.5), axis.ticks.length = unit(0.3, 'cm')) +
  geom_vline(xintercept = 2, linetype=2, size=1.5, color="darkgray")
dev.off()

# ---
# DP
# ---
stats$DP_normed = stats$DP/(stats$AN/2)
png(args[4], width=13, height=5, units = "in", res = 300)
p1 = ggplot(stats, aes(x=DP)) +
  geom_density() +
  theme_bw() +
  theme(axis.text.x = element_text(size=16, colour="black"), axis.text.y = element_text(size=16, colour = "black"), axis.title= element_text(size=16), axis.line=element_line(colour = "black"), axis.ticks = element_line(colour = "black", size=1.5), axis.ticks.length = unit(0.3, 'cm'))

p2 = ggplot(stats, aes(x=DP_normed)) +
  geom_density() +
  theme_bw() +
  labs(x="DP normalized by AN")
  theme(axis.text.x = element_text(size=16, colour="black"), axis.text.y = element_text(size=16, colour = "black"), axis.title= element_text(size=16), axis.line=element_line(colour = "black"), axis.ticks = element_line(colour = "black", size=1.5), axis.ticks.length = unit(0.3, 'cm'))
  
ggarrange(p1, p2, ncol=2)
dev.off()

out = data.frame(DP_mean = mean(stats$DP), DP_median = median(stats$DP), DP_normed_mean = mean(stats$DP_normed), DP_normed_median = median(stats$DP_normed))
write.table(out, args[6], quote = F, row.names = F, sep = "\t")

# ---
# MQ
# ---
png(args[5], width=8, height=5, units = "in", res = 300)
ggplot(stats, aes(x=MQ)) +
  geom_density() +
  theme_bw() +
  theme(axis.text.x = element_text(size=16, colour="black"), axis.text.y = element_text(size=16, colour = "black"), axis.title= element_text(size=16), axis.line=element_line(colour = "black"), axis.ticks = element_line(colour = "black", size=1.5), axis.ticks.length = unit(0.3, 'cm')) +
  geom_vline(xintercept = 40, linetype=2, size=1.5, color="darkgray")
dev.off()