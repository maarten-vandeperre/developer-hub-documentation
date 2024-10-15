import React from 'react';
import {Box, Grid, Paper, styled} from "@material-ui/core";
import LinearProgress, {LinearProgressProps} from '@mui/material/LinearProgress';
import Typography from '@mui/material/Typography';

const Item = styled(Paper)(({theme}) => ({
    backgroundColor: 'none',
    ...theme.typography.body2,
    padding: '20px',
    textAlign: 'center',
    color: theme.palette.text.secondary,
}));

function LinearProgressWithLabel(props: LinearProgressProps & { label: string }) {
    console.error(props.label)
    return (
        <div>
            <b>Request x</b>
            <Box sx={{display: 'flex', alignItems: 'center'}}>
                <Box sx={{width: '85%', mr: 1}}>
                    <LinearProgress variant="determinate" {...props} />
                </Box>
                <Box sx={{minWidth: 85}}>
                    <Typography
                        variant="body2"
                        sx={{color: 'text.secondary'}}
                    >{`${props.label}`}</Typography>
                </Box>
            </Box>
        </div>
    );
}

function getLabel(progress: number): string {
    switch (progress) {
        case 0:
            return 'Request submitted.'
        case 25:
            return 'Request Approved.'
        case 50:
            return 'Request being processed.'
        case 75:
            return 'Waiting for approval.'
        case 100:
            return 'Done.'
        default:
            return 'Unknown.'
    }
}

const StatusItem = () => {
    var min = 0;
    var max = 100;
    var rand = min + (Math.random() * (max - min));
    const initial = Math.floor(rand / 25) * 25;

    const [progress, setProgress] = React.useState(initial);
    // @ts-ignore
    const [label, setLabel] = React.useState(getLabel(progress));
    const increment = 25;

    React.useEffect(() => {
        const timer = setInterval(() => {
            setProgress((prevProgress) => (prevProgress >= 100 ? increment : prevProgress + increment));
            setLabel(getLabel(progress))
        }, 2400);
        return () => {
            clearInterval(timer);
        };
    }, []);

    return (
        <LinearProgressWithLabel value={progress} label={getLabel(progress)}/>
    );
}

export const RequestStatus = () => {
    return (
        <Box sx={{flexGrow: 1}}>
            <Grid container spacing={2}>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
                <Grid item xs={12} md={12} style={{"background": "none"}}>
                    <Item>
                        <StatusItem/>
                    </Item>
                </Grid>
            </Grid>
        </Box>
    );
};