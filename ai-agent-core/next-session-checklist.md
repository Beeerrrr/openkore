# MATS-REQ Mapping Follow-Up Checklist

## For User / Makers

- **Validate workflow copy**: Confirm each workflow_state entry in `Microsoft.PowerApps/apps/ai-agent-core/mapping/components.json` still matches the business stage names (e.g., `Draft -> Submitted`, `QA Review -> QA Final -> Completed / Send back`). Update mapping once stakeholders approve any naming changes.
- **Session collection behaviour**: Spot-check `AdtnItems` and `EDAdtnItems` in Studio to ensure the frequent Clear/Collect cycle cannot wipe data when multiple reviewers open the same case. If risky, consider gating navigation or staging data in SharePoint.
- **Permission refresh expectation**: Decide whether `colUserPermissions`/`colUserPermissionsActive` should refresh mid-session. If yes, log a requirement to add an explicit refresh (e.g., on Portal_Cases reload).
- **Workflow evolution**: If new case stages or departments are added, schedule a re-run of the mapping extractor immediately afterward so dependencies.json stays authoritative.

## For Assistant (Next Session)

- Re-run the YAML scan to regenerate `cache/mapping_summary.json` after any canvas app export; then trigger the mapping rebuild script so components/variables/dependencies stay in sync.
- When reprocessing data sources, strip function wrappers like `Sequence(CountRows(...` so external dependency lists only include real connectors (SharePoint, collections, etc.).
- Review whether a lightweight automation (PowerShell or Python) can refresh permission collections on demand and document the result for makers.
- Check that `mapping/variables.json` entries for the collections include both `App.Clear` and `App.Collect` now; adjust if maker changes shift those responsibilities.
