# Prompt de session LLM (français — partie variable)

## Règles fixes et faits projet

**Tout le contexte figé (décisions + faits) est dans [llm_session_bilingual.md](llm_session_bilingual.md).**  
Pour un nouveau fil ou après un changement de règles, copiez d’abord le bloc **« 貼り付け用・固定部 »** (sections japonaise et française).

---

## À remplir à chaque session (français)

Quand le bloc fixe est déjà envoyé, ou pour ne mettre à jour que l’état courant :

```
【Langues pour cette session】
- Consignes (utilisateur) : <français, etc.>
- Réponses (assistant) : <français, etc.>

【Avancement】
- Déjà fait : <puces>
- En cours / suite : <puces>
- Blocages : <si besoin / aucun>

【Demande】
<Tâche précise, livrables et comportement attendu>

【Fichiers à privilégier (optionnel)】
<ex. section précise dans plan/plan001/fr/architecture_decisions_fr.md>
```

---

## Version très courte (suite du même fil)

```
【Delta】<ce qui a changé depuis la dernière fois>
【Demande】<tâche du moment>
```

Après une longue pause ou un changement de direction, renvoyer le bloc fixe depuis `llm_session_bilingual.md`.
