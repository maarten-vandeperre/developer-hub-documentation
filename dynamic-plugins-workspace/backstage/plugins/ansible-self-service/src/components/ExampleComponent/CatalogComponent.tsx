import React from 'react';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import AddIcon from '@material-ui/icons/Add';
import InfoIcon from '@material-ui/icons/Info';
import {Box, Grid, Paper, styled} from "@material-ui/core";

const Item = styled(Paper)(({theme}) => ({
    backgroundColor: 'none',
    ...theme.typography.body2,
    padding: 0,
    textAlign: 'center',
    color: theme.palette.text.secondary,
}));

function printCard(title: String, description: String) {
    return (
        <Card sx={{maxWidth: 345}}>
            <CardMedia
                component="img"
                alt="green iguana"
                height="160"
                style={{background: "black", padding: "20px"}}
                image="https://developers.redhat.com/themes/custom/rhdp_fe/images/branding/2023_RHDLogo_reverse.svg"
            />
            <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                    {title}
                </Typography>
                <Typography variant="body2" sx={{color: 'text.secondary'}}>
                    {description}
                </Typography>
            </CardContent>
            <CardActions>
                <Button size="small" variant="outlined" startIcon={<AddIcon/>}>Request</Button>
                <Button size="small" variant="outlined" startIcon={<InfoIcon/>}>Learn More</Button>
            </CardActions>
        </Card>
    );
}

export const CatalogComponent = () => {
    return (
        <Box sx={{flexGrow: 1}}>
            <Grid container spacing={2}>
                <Grid item xs={3} md={3} style={{"background": "none"}}>
                    <Item>{printCard("Request VM", "A virtual machine (VM) provides an isolated environment with dedicated compute, memory, and storage resources for running applications or services. Requesting a VM typically involves selecting the desired operating system, resource allocation, and networking configurations to support specific workloads or development needs.")}</Item>
                </Grid>
                <Grid item xs={3} md={3}>
                    <Item>{printCard("Request ODC+", "An OpenShift cluster provides a flexible and scalable platform for deploying, managing, and automating containerized applications using Kubernetes. Requesting a cluster typically involves provisioning resources such as compute, storage, and networking to support application development and operational workflows within an enterprise environment.")}</Item>
                </Grid>
                <Grid item xs={3} md={3}>
                    <Item>{printCard("Add Node to cluster", "Requesting an extra node for an OpenShift cluster involves adding additional compute resources to scale workloads, improve performance, or enhance redundancy. This typically requires specifying the node type (e.g., worker or infra) and ensuring adequate capacity in terms of CPU, memory, and storage to support the increased demands on the cluster.")}</Item>
                </Grid>
                <Grid item xs={3} md={3}>
                    <Item>{printCard("Add AI layer", "Requesting OpenShift AI provides access to an integrated platform for developing, training, and deploying AI/ML models at scale using Kubernetes and containerized workloads. This typically involves provisioning specialized resources like GPUs, optimized storage, and machine learning frameworks to support high-performance AI workflows in a secure and scalable environment.")}</Item>
                </Grid>
            </Grid>
        </Box>
    );
}