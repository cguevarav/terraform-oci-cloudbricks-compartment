# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# datasource.tf
#
# Purpose: The following script defines the lookup logic used in code to obtain pre-created or JIT-created resources in tenancy.


/********** Compartment and CF Accessors **********/
data "oci_identity_compartments" "PARENTCOMPARTMENT" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.parent_compartment_name]
  }
}

data "oci_identity_compartments" "PARENTCOMPARTMENTLINE" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.compartment_line]
  }
}





data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}


locals {
  release = "1.0"
  # Compartment OCID Local Accessor
  parent_compartment_id = length(regexall("ocid", var.parent_compartment_name)) > 0 ? var.parent_compartment_name : (length(data.oci_identity_compartments.PARENTCOMPARTMENT.compartments) > 0 ? data.oci_identity_compartments.PARENTCOMPARTMENT.compartments[0].id : "")
  line_compartment_id = length(regexall("ocid", var.compartment_line)) > 0 ? var.compartment_line : (length(data.oci_identity_compartments.PARENTCOMPARTMENTLINE.compartments) > 0 ? data.oci_identity_compartments.PARENTCOMPARTMENTLINE.compartments[0].id : "")

}








