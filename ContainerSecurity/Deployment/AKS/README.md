# Despliegue Automatizado de Container Security en AKS

Este repositorio documenta y centraliza los procesos utilizados para automatizar el despliegue de **Trend Vision One - Container Security** sobre clústeres de **Azure Kubernetes Service (AKS)**.

## Objetivo

El propósito de este espacio es dejar documentados (scripts, plantillas y procedimientos) los pasos necesarios para implementar Container Security de forma **automatizada y repetible** en infraestructuras masivas, es decir, entornos con un gran número de clústeres/recursos AKS ya existentes, donde una instalación manual, clúster por clúster, no es viable ni sostenible en el tiempo.

## Contexto y Alcance

En infraestructuras a gran escala, el despliegue de Container Security debe cumplir con los siguientes requisitos:

- **Automatización sobre recursos existentes**: los procesos aquí documentados están pensados para aplicarse sobre clústeres AKS ya provisionados (brownfield), sin depender de que la protección se incluya desde el aprovisionamiento inicial.
- **Escalabilidad**: los scripts y flujos deben poder ejecutarse contra múltiples suscripciones, resource groups y clústeres de forma masiva, sin intervención manual por recurso.
- **Cobertura del 100%**: el objetivo final es garantizar y mantener que **todos** los clústeres AKS dentro del alcance cuenten con Container Security desplegado y operativo, incluyendo la detección y remediación de clústeres que queden fuera de cumplimiento (drift) por nuevos despliegues o cambios de configuración.
- **Mantenimiento continuo**: no se trata solo de un despliegue inicial, sino de procesos que permitan verificar periódicamente el estado de la protección y volver a aplicar la configuración cuando sea necesario.

## Contenido

En esta carpeta se irán agregando, a medida que se documenten:

- Scripts de despliegue automatizado (CLI/Az CLI, Terraform, Bicep, Helm, etc.)
- Plantillas de configuración (`overrides.yaml` y similares) para Container Security en AKS
- Procesos de validación/auditoría de cobertura sobre el parque de clústeres
- Guías paso a paso para escenarios de despliegue masivo

## Requisitos

- Suscripción de Azure con permisos suficientes sobre los recursos AKS objetivo
- Cuenta de Trend Vision One con acceso a Container Security
- Herramientas de línea de comandos: Azure CLI, `kubectl`, `helm` (según el script)

## Notas

Este contenido forma parte del proyecto comunitario [v1-cloud-community](../../../README.md). Las contribuciones son bienvenidas siguiendo las [Contributor Guidelines](../../../README.md#for-contributors) del repositorio principal.
