-- view_desempenho_atendente
create view desempenho_atendente as
select 
da.id_atendente, 
da.nome, 
da.nivel, 
count(fc.id_chamado) as chamados_atendidos,
round(avg(timestampdiff(minute, fc.data_aceite, fc.data_fechamento)), 2) as tempo_medio_atendimento,
round(avg(timestampdiff(minute, fc.data_abertura, fc.data_aceite)), 1)as tempo_medio_aceite,
round(avg(fc.nota), 2) as nota_media,
ROUND((SUM(IF(TIMESTAMPDIFF(MINUTE, fc.data_aceite, fc.data_fechamento) <= dcc.prazo_maximo, 1, 0))
/ NULLIF(COUNT(fc.id_chamado), 0)) * 100, 2) as percentual_SLA

from dim_atendente da
left join fato_chamado fc
using (id_atendente)
left join dim_categoria_chamado dcc
using(id_categoria_chamado)
group by da.id_atendente, da.nome, da.nivel;
