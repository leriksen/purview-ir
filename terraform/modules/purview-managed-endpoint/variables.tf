variable name {
  type = string
}

variable purview_endpoint {
  type = string
}

variable mvnet_name {
  type = string
}

variable resource_id {
  type = string
}

variable subresource {
  type = string
  validation {
    error_message = "subresource doesnt match values allowed for resource_kind"
    condition     = anytrue(
      [
        alltrue(
          [
            contains(
              [
                "blob",
                "blob_secondary",
                "table",
                "table_secondary",
                "queue",
                "queue_secondary",
                "dfs",
                "dfs_secondary",
                "file",
                "file_secondary",
              ],
              var.subresource
            ),
            var.resource_kind == "sa"
          ]
        ),
        alltrue(
          [
            contains(
              [
                "SQL",
                "MongoDB",
                "Cassandra",
                "Gremlin",
                "Table",
              ],
              var.subresource
            ),
            var.resource_kind == "cosmosdb"
          ]
        ),
        alltrue(
          [
            contains(
              [
                "Sql",
                "sql",
                "SqlOnDemand",
                "Dev",
              ],
              var.subresource
            ),
            var.resource_kind == "synapse"
          ]
        ),
        alltrue(
          [
            var.resource_kind == "kv",
            var.subresource   == "vault"
          ]
        ),
      ]
    )
  }
}

#  ?
#     ) :
#
# : false

variable resource_kind {
  type = string
}


