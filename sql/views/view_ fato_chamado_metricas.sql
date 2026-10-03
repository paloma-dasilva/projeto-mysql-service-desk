
-- view fato_chamado_metricas
 create view fato_chamado_metricas as 
 select 
 fc.id_chamado, dc.id_cliente, dc.id_localidade, da.id_atendente,  dcc.id_categoria_chamado,
 fc.canal, fc.data_abertura, fc.data_aceite, fc.data_fechamento,
greatest(0, timestampdiff(minute, fc.data_abertura, fc.data_aceite)) as tempo_espera_minutos,
greatest(0, timestampdiff(minute, fc.data_aceite, fc.data_fechamento)) as tempo_atendimento_minutos,
 
 if(timestampdiff(minute, fc.data_aceite, fc.data_fechamento)  <= dcc.prazo_maximo,
 'No prazo', 'Atrasado'
 ) as status_SLA,
 
 fc.nota as nota_atendimento
 from fato_chamado fc
 
 join dim_cliente dc
 using (id_cliente)
 join dim_atendente da
 using (id_atendente)
join dim_categoria_chamado dcc
using(id_categoria_chamado);




